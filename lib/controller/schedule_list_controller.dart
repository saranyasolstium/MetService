import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eagle_pixels/reuse/date_manager.dart';

class ScheduleListController extends GetxController {
  var scheduleList = <ScheduleList>[].obs;
  final selectedDate = DateTime.now().obs;
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
    print('reached');
    scheduleList.value = resp.model.data;

    List<ScheduleList> sampleList = [];

    for (int i = 1; i <= 10; i++) {
      ScheduleList scheduleListdemo = ScheduleList();

      sampleList.add(scheduleListdemo);
    }

    scheduleList.value = sampleList;
    print(scheduleList);

    @override
    void disposeId(Object id) {
      print('dispoed id $id');
      super.disposeId(id);
    }

    // try {
    //   showLoading();
    //   scheduleList.value = await _fetchList();
    // } finally {
    //   hideLoading();
    // }
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
