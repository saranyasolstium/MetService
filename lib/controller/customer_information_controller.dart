import 'package:eagle_pixels/model/create_job_customerList_model.dart';
import 'package:eagle_pixels/model/create_job_itemList_model.dart';
import 'package:eagle_pixels/model/service_type_model.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/model/abstract_class.dart';

import '../api/api_service.dart';
import '../api/urls.dart';
import '../constant.dart';
import '../model/abstract_class.dart';
import '../model/get_scheduled_job.dart';

class CustomerInformationController extends GetxController {
  var customerList = <MCustomerItem>[].obs;
  var locationList = <ADropDown>[].obs;
  var productList = <MCustomerProductItem>[].obs;
  var filteredProductList = <MCustomerProductItem>[].obs;

  final Rx<ADropDown?> selectedCustomer = Rx(null);
  final Rx<ADropDown?> selectedLocation = Rx(null);
  final Rx<ADropDown?> selectedProduct = Rx(null);

  final viewState = ViewState.success;

  @override
  void onInit() async {
    filteredProductList.add(MCustomerProductItem());
    await fetchCustomerList();
    super.onInit();
  }

  List<String> arrString(List<ADropDown> list) {
    return list.map((e) => e.aName).toList();
  }

  ADropDown find(String selected, List<ADropDown> list) {
    return list.firstWhere((element) => element.aName == selected);
  }

  fetchCustomerList() async {
    var response = await API.service.call(
      endPoint: EndPoint.getCustomerList,
      model: MCustomerList(),
    );
    if (response.isValidModel) {
      customerList.value = response.model!.data;
      // filteredProductList.value = response.model!.data;
    }
  }

  fetchCustomerProductList() async {
    var response = await API.service.call(
        endPoint: EndPoint.getCustomerProductItemList,
        model: MCustomerProductList(),
        body: {'customer_id': selectedCustomer.value?.aId ?? 0});
    if (response.isValidModel) {
      productList.value = response.model!.data;
    } else {
      productList.value = [];
    }
  }
}
