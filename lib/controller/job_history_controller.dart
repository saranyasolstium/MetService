import 'package:get/get.dart';
import 'package:intl/intl.dart';

class JobHistoryController extends GetxController {
  // ignore: deprecated_member_use
  var jobList = List<int>().obs;
  final selectedDate = DateTime.now().obs;
  // var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    // var resp = await API.service.call(
    //   model: ScheduleResponse(),
    //   endPoint: EndPoint.scheduled_job_list,
    //   body: {'date': serviceDate(selectedDate.value)},
    // );
    // scheduleList.value = resp.model.data;
  }
}
