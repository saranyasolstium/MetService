import 'package:get/get.dart';
import '../api/ParamModel.dart';
import '../api/api_service.dart';
import '../api/urls.dart';
import '../api/urls.dart';
import '../constant.dart';
import '../model/abstract_class.dart';
import '../model/abstract_class.dart';
import '../model/create_job_customerList_model.dart';
import '../model/create_job_itemList_model.dart';
import 'package:eagle_pixels/model/service_type_model.dart';

class CreateJobController extends GetxController {
  final valueOfDrop = ''.obs;

  var customerList = <MCustomerItem>[].obs;
  var customerProductList = <MCustomerProductItem>[].obs;
  var serviceTypeList = <MServiceType>[].obs;

  void setSelected(String value) {
    valueOfDrop.value = value;
  }

  @override
  void onInit() async {
    await fetchCustomerList();
    await fetchServiceType();
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
        model: MCustomerProductList.init(),
        body: {'customer_id': cusID});
    if (response.isValidModel) {
      customerProductList.value = response.model!.data;
    } else {
      customerProductList.value = [];
    }
  }

  fetchServiceType() async {
    var response = await API.service.call(
      endPoint: EndPoint.serviceTypeList,
      model: MServiceTypeResponse(),
    );
    if (response.isValidModel) {
      serviceTypeList.value = response.model!.data;
    } else {
      serviceTypeList.value = [];
    }
  }

  Future<bool> scCreateJob(ParamCreateJob param) async {
    final response = await API.service.call(
      endPoint: EndPoint.createJob,
      body: param.toJson(),
    );
    if (response.isSuccess) {
      return true;
    } else {
      return Future.error(response.message ?? kErrorMsg);
    }
  }
}
