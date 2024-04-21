import 'dart:convert';
import 'dart:io';

import 'package:eagle_pixels/api/ParamModel.dart';
import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

class ScheduleListController extends GetxController {
  var scheduleList = <MScheduledJobItem>[].obs;
  var selectedDate;
  final viewState = ViewState.loading.obs;
  reloadList() {
    fetchScheduleList();
  }
  // var isLoading = true.obs;

  @override
  void onInit() {
    selectedDate = DateTime.now().obs;
    fetchScheduleList();
    super.onInit();
  }

  clearMemory() {
    print('ScheduleListController controller deinited');
  }

  @override
  void onClose() {
    clearMemory();
    super.onClose();
  }

  @override
  void dispose() {
    clearMemory();
    super.dispose();
  }

  @override
  void disposeId(Object id) {
    print('dispoed id $id');
    super.disposeId(id);
  }

  String serviceDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // String displayDate() {
  //
  //   return DateFormat('yyyy-MM-dd').format(selectedDate.value);
  // }

  // Future<List<ScheduleList>> _fetchList() async {
  //   var response = await API.service.call(
  //       endPoint: EndPoint.scheduled_job_list,
  //       query: {'date': serviceDate(selectedDate.value)});
  //   if (response.statusCode == 200) {
  //     var jsonString = response.body;
  //     print(jsonString);
  //     return getScheduledListFromJson(jsonString).data;
  //   } else {
  //     //show error message
  //     return [];
  //   }
  // }
}

extension ScheduleListService on ScheduleListController {
  void fetchScheduleList() async {
    var resp = await API.service.call(
      model: ScheduleResponse(),
      endPoint: EndPoint.scheduled_job_list,
      body: {'date': serviceDate(selectedDate.value)},
    );

    scheduleList.value = resp.model!.data;
    // scheduleList.add(MScheduledJobItem(id: '41'));
    if (scheduleList.length > 0) {
      viewState.value = ViewState.success;
    } else {
      viewState.value = ViewState.failed;
    }
    // List<MScheduledJobItem> sampleList = [];
    //
    // for (int i = 1; i <= 10; i++) {
    //   MScheduledJobItem scheduleListdemo = MScheduledJobItem();
    //
    //   sampleList.add(scheduleListdemo);
    // }
    //
    // scheduleList.value = sampleList;
    // print(scheduleList);

    // try {
    //   showLoading();
    //   scheduleList.value = await _fetchList();
    // } finally {
    //   hideLoading();
    // }
  }

  Future<Map> onStartJob(
      {required String service_id}) async {
    Position position = await AppController.to.determinePosition();
    print('Allowed location permission');
    // File imageFile = File(imagePath);
    // List<int> imageBytes = await imageFile.readAsBytes();

    // String base64Image = base64Encode(imageBytes);

    var response = await API.service.call(
      endPoint: EndPoint.startJob,
      body: ParamStartJob(
              service_id, position.latitude, position.longitude, "")
          .toJson(),
    );
    return response.map;
  }

  // ignore: non_constant_identifier_names
  Future<Map> onStopJob({required String service_id}) async {
    Position position = await AppController.to.determinePosition();
    print('Allowed location permission');
    var response = await API.service.call(
      endPoint: EndPoint.stopJob,
      body: ParamStartJob(service_id, position.latitude, position.longitude,"")
          .toJson(),
    );
    return response.map;
  }
}
