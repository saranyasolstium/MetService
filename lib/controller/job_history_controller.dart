import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eagle_pixels/model/job_history_item.dart';
import 'package:eagle_pixels/reuse/date_manager.dart';

class JobHistoryController extends GetxController {
  // ignore: deprecated_member_use
  var jobList = List<MJobHistoryItem>().obs;
  final selectedDate = DateTime.now().obs;
  // var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    List<MJobHistoryItem> sampleList = [];

    for (int i = 1; i <= 10; i++) {
      sampleList.add(MJobHistoryItem());
    }

    jobList.value = sampleList;

    // var resp = await API.service.call(
    //   model: MJobHistoryListResponse(),
    //   endPoint: EndPoint.job_history_list,
    //   body: {'date': selectedDate.value.changeDay},
    // );
    // jobList.value = resp.model.data;
  }
}
