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
  var checklistData = MCheckListResponse().obs;
  List<MCheckListItem> get checkList {
    return checklistData.value.data?.first.list ?? [];
  }

  List<MCheckListItem> get selectedlist {
    return checklistData.value.data?.first.selectedItems ?? [];
  }

  bool isOneTimeListRequested = false;

  fetchCheckList(String serviceID) async {
    var response = await API.service.call(
      model: MCheckListResponse(),
      endPoint: EndPoint.checkList,
      body: {'service_id': serviceID, 'message': 'test close via API'},
    );
    this.checklistData.value = response.model!;
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
  void onInit() {
    // checkList.value = sampleData();
    // ever(checkList, some());
    // Future.delayed(Duration(seconds: 1), () => fetchCheckList());
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
      return null;
    } else {
      return response.message ?? kErrorMsg;
    }
  }
}
