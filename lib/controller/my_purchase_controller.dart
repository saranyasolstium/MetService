import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/model/create_job_itemList_model.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:eagle_pixels/model/job_history_item.dart';
import 'package:eagle_pixels/reuse/date_manager.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/model/job_history_item.dart';
import 'package:intl/intl.dart';

import '../api/api_service.dart';
import '../api/urls.dart';
import '../constant.dart';
import '../model/abstract_class.dart';

class MyPurchaseController extends GetxController {
  // ignore: deprecated_member_use
  var jobList = <MCustomerProductItem>[].obs;
  final selectedDate = DateTime.now().obs;
  final viewState = ViewState.loading.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    viewState.value = ViewState.loading;
    var response = await API.service.call(
        endPoint: EndPoint.getCustomerProductItemList,
        model: MCustomerProductList.init(),
        body: {
          'customer_id': AppController.user.id,
          // 'date':
          //     DateFormat(AppDateFormat.yyyy_MM_dd).format(selectedDate.value),
        });
    // body: {'customer_id': cusID});
    if (response.isValidModel) {
      // jobList.value = response.model!.data;
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
  //service integration pull to refresh, pagination.
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
