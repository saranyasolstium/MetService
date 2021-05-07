import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
    try {
      showLoading();
      scheduleList.value = await _fetchList();
    } finally {
      hideLoading();
    }
  }

  Future<List<ScheduleList>> _fetchList() async {
    var response = await API.service.call(
        endPoint: EndPoint.scheduled_job_list,
        query: {'date': DateFormat('yyyy-MM-dd').format(selectedDate.value)});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);
      return getScheduledListFromJson(jsonString).data;
    } else {
      //show error message
      return [];
    }
  }
}
