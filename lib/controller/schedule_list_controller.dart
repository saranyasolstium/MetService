import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

class ScheduleListController extends GetxController {
  var scheduleList = <MScheduledJobItem>[].obs;
  final selectedDate = DateTime(2021, 2, 9).obs; //temp
  final viewState = ViewState.loading.obs;
  // var isLoading = true.obs;

  @override
  void onInit() {
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

  void fetchScheduleList() async {
    var resp = await API.service.call(
      model: ScheduleResponse(),
      endPoint: EndPoint.scheduled_job_list,
      body: {'date': serviceDate(selectedDate.value)},
    );
    scheduleList.value = resp.model!.data!;
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
