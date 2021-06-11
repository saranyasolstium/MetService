import 'package:eagle_pixels/api/ParamModel.dart';
import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/main.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/model/check_list_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:signature/signature.dart';

import '../colors.dart';
import 'job_detail_controller.dart';

// class MCheckListItem {
//   String id;
//   String title;
//   Color color;
//   MCheckListItem({required this.id, required this.title, required this.color});
// }

// class MCheckList implements ACheckList, Codable {
//   List<MCheckListItem>? options;
//   MCheckListItem? selectedItem;
//
//   String? status;
//
//   Codable fromJson(Map<String, dynamic> map) {
//     var model = MCheckList();
//     return model;
//   }
//
//   bool get isValid => true;
//
//   toJson() {
//     // TODO: implement toJson
//     throw UnimplementedError();
//   }
//
//   @override
//   String? remarks;
//
//   @override
//   String? title;
//
//   @override
//   String? id;
// }

class JobCheckListController extends GetxController {
  var checklistData = MCheckListResponse.init().obs;
  List<MCheckListItem> get checkList {
    if (checklistData.value.data.length > 0) {
      return checklistData.value.data.first.list ?? [];
    } else
      return [];
  }

  List<MCheckListItem> get selectedlist {
    if (checklistData.value.data.length > 0) {
      return checklistData.value.data.first.selectedItems;
    } else
      return [];
  }

  final detail = Get.find<JobDetailController>();
  bool isOneTimeListRequested = false;

  fetchCheckList(String serviceID) async {
    var response = await API.service.call(
      needLoader: false,
      model: MCheckListResponse.init(),
      endPoint: EndPoint.checkList,
      body: {'service_id': serviceID},
    );
    this.checklistData.value = response.model!;
    print('${response.model!.data.length} Response');
    MCheckListItem tempData = MCheckListItem();
    tempData.name = 'Option';
    tempData.itemID = 10;
    tempData.selectedImages = [];
    tempData.noteRequired = 1;
    tempData.options = null;
    // checklistData.value.data.add(MCheckList.fromJson({}));
    // checklistData.value.data.first.list = [];
    // checklistData.value.data.first.list?.add(tempData);
    update();
  }
  // List<ACheckList> get selectedList {
  //   (checklistData.value.data?.first?.ll ?? [])
  //   return checkList.where((item) => item.selectedItem != null).toList();
  // }

  // List<MCheckList> sampleData() {
  //   var models = <MCheckListItem>[];
  //   for (int i = 0; i <= 10; i++) {
  //     var model = MCheckListItem();
  //     model.options = [];
  //
  //     model.options!
  //         .add(MCheckListItem(id: '1', title: "Fixed", color: Colour.appBlue));
  //     model.options!.add(
  //         MCheckListItem(id: '2', title: "Non Fixable", color: Colour.appRed));
  //     models.add(model);
  //   }
  //   return models;
  // }

  @override
  void onInit() async {
    // checkList.value = sampleData();

    // Future.delayed(
    //     Duration(seconds: 2),
    //     () async =>
    //         await fetchCheckList(detail.detail.value.aServiceId.toString()));
    // await fetchCheckList('41'); //temp
    // ever(checkList, some());
    // Future.delayed(Duration(seconds: 1), () => fetchCheckList());
    fetchCheckList(detail.detail.value.aServiceId.toString());
    super.onInit();
  }

  // some() {
  //   print('model updated');
  //   Future.delayed(Duration(seconds: 10), () {
  //     checkList.value = sampleData();
  //   });
  // }

  Future<String?> onSubmitJob(
      // ignore: non_constant_identifier_names
      {required String service_id}) async {
    Position position = await AppController.to.determinePosition();
    var param = await ParamSubmitJob(
            serviceID: service_id, checkList: this.selectedlist)
        .toJson();
    var response = await API.service.call(
      endPoint: EndPoint.submitJob,
      body: param,
    );
    hideLoading();
    if (response.isSuccess) {
      return null;
    } else {
      return response.message ?? kErrorMsg;
    }
  }

  Future<String?> onCompleteJob(
      // ignore: non_constant_identifier_names
      {required String service_id,
      required double rating,
      required signature,
      required String feedback}) async {
    // Position position = await AppController.to.determinePosition();
    var param = await ParamCompleteJob(
      serviceID: service_id,
      rating: rating,
      signature: signature,
      feedback: feedback,
    ).toJson();
    var response = await API.service.call(
      endPoint: EndPoint.completeJob,
      body: param,
    );
    hideLoading();
    if (response.isSuccess) {
      detail.completedMessage = response.message ?? 'Job Completed';
      return null;
    } else {
      return response.message ?? kErrorMsg;
    }
  }
}
