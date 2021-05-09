import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eagle_pixels/reuse/date_manager.dart';

class ScheduleListController extends GetxController {
  var scheduleList = List<ScheduleList>().obs;
  final selectedDate = DateTime.now().obs;
  // var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    var resp = await API.service.call(
      model: ScheduleResponse(),
      endPoint: EndPoint.scheduled_job_list,
      body: {'date': serviceDate(selectedDate.value)},
    );
    scheduleList.value = resp.model.data;

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
