import 'package:get/get.dart';
import '../api/api_service.dart';
import '../api/urls.dart';
import '../model/abstract_class.dart';
import '../model/abstract_class.dart';
import '../model/create_job_customerList_model.dart';
import '../model/create_job_itemList_model.dart';

class CreateJobController extends GetxController {
  final valueOfDrop = ''.obs;

  var customerList = <MCustomerItem>[].obs;
  var customerProductList = <MCustomerProductItem>[].obs;

  void setSelected(String value) {
    valueOfDrop.value = value;
  }

  @override
  void onInit() async {
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
    }
  }

  fetchCustomerProductList(String cusID) async {
    var response = await API.service.call(
        endPoint: EndPoint.getCustomerProductItemList,
        model: MCustomerProductList(),
        body: {'customer_id': cusID});
    if (response.isValidModel) {
      customerProductList.value = response.model!.data;
    } else {
      customerProductList.value = [];
    }
  }
}
