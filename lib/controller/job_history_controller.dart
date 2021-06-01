import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/model/job_history_item.dart';
import 'package:eagle_pixels/reuse/date_manager.dart';

class JobHistoryController extends GetxController {
  // ignore: deprecated_member_use
  var jobList = <MScheduledJobItem>[].obs;
  final selectedDate = DateTime.now().obs;
  final viewState = ViewState.loading.obs;

  // var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    // List<MJobHistoryItem> sampleList = [];
    //
    // for (int i = 1; i <= 10; i++) {
    //   sampleList.add(MJobHistoryItem());
    // }
    //
    // jobList.value = sampleList;
    var resp = await API.service.call(
      model: ScheduleResponse(),
      endPoint: EndPoint.job_history_list,
      body: {'date': selectedDate.value.changeDay},
    );
    jobList.value = resp.model!.data ?? [];
    if (jobList.length > 0) {
      viewState.value = ViewState.success;
    } else {
      viewState.value = ViewState.failed;
    }
  }
}
