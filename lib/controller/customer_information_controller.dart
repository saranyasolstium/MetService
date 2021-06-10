import 'package:eagle_pixels/model/create_job_customerList_model.dart';
import 'package:eagle_pixels/model/create_job_itemList_model.dart';
import 'package:eagle_pixels/model/store_list_model.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/model/abstract_class.dart';

import '../api/api_service.dart';
import '../api/urls.dart';
import '../constant.dart';
import '../model/abstract_class.dart';

class CustomerInformationController extends GetxController {
  var customerList = <MCustomerItem>[].obs;
  var locationList = <MCustomerSiteItem>[].obs;
  var productList = <MCustomerProductItem>[].obs;
  var filteredProductList = <MCustomerProductItem>[].obs;

  final Rx<ADropDown?> selectedCustomer = Rx(null);
  final Rx<ADropDown?> selectedLocation = Rx(null);
  final Rx<ADropDown?> selectedProduct = Rx(null);

  final viewState = ViewState.success;

  @override
  void onInit() async {
    // filteredProductList
    //     .add(MCustomerProductItem(productId: 1, productName: 'Soona Paana'));
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
      customerList.value = response.model!.data
          .where((element) => element.aId.trim().length > 0)
          .toList();
      // filteredProductList.value = response.model!.data;
    }
  }

  fetchCustomerProductList(bool isDropDown) async {
    Map<String, dynamic> param = {};
    param['customer_id'] = selectedCustomer.value?.aId ?? 0;
    param['site_id'] = selectedLocation.value?.aId ?? '';
    param['id'] = isDropDown ? '' : selectedProduct.value?.aId ?? '';
    param['date'] = '';
    var response = await API.service.call(
      endPoint: EndPoint.getCustomerProductItemList,
      model: MCustomerProductList.init(),
      body: param,
    );
    if (isDropDown) {
      productList.value = response.model!.data;
    } else {
      filteredProductList.value = response.model!.data;
    }
  }

  fetchCustomerStoreList() async {
    var response = await API.service.call(
        endPoint: EndPoint.getCustomerStoreList,
        model: MCustomerSite.init(),
        body: {'customer_id': selectedCustomer.value?.aId ?? 0});
    if (response.isValidModel) {
      locationList.value = response.model!.data;
    } else {
      locationList.value = [];
    }
  }
}
