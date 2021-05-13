import 'package:eagle_pixels/model/job_history_item.dart';
import 'package:get/get.dart';

class MyPurchaseController extends GetxController {
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
    //temp service integration pull to refresh, pagination, pdf functionality.
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