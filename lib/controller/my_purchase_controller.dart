import 'package:eagle_pixels/model/create_job_itemList_model.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:eagle_pixels/model/job_history_item.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/model/job_history_item.dart';

import '../api/api_service.dart';
import '../api/urls.dart';
import '../constant.dart';
import '../model/abstract_class.dart';

class MyPurchaseController extends GetxController {
  // ignore: deprecated_member_use
  var jobList = <AServiceItem>[].obs;
  final selectedDate = DateTime.now().obs;
  final viewState = ViewState.loading.obs;

  // var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    var response = await API.service.call(
      endPoint: EndPoint.getCustomerProductItemList,
      model: MCustomerProductList(),
    );
    // body: {'customer_id': cusID});
    if (response.isValidModel) {
      jobList.value = response.model!.data;
    } else {
      jobList.value = [];
    }
    if (jobList.length > 0) {
      viewState.value = ViewState.success;
    } else {
      viewState.value = ViewState.failed;
    }
  }

  // void fetchProducts() async {
  //
  //   List<MScheduledJobItem> sampleList = [];
  //   //temp service integration pull to refresh, pagination.
  //   for (int i = 1; i <= 10; i++) {
  //     sampleList.add(MScheduledJobItem());
  //   }
  //
  //   jobList.value = sampleList;

  //   // var resp = await API.service.call(
  //   //   model: MJobHistoryListResponse(),
  //   //   endPoint: EndPoint.job_history_list,
  //   //   body: {'date': selectedDate.value.changeDay},
  //   // );
  //   // jobList.value = resp.model.data;
  // }
}
