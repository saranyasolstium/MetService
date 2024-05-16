import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:get/get.dart';
import '../api/ParamModel.dart';
import '../api/api_service.dart';
import '../api/urls.dart';
import '../constant.dart';
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

  // List<String> arrString(List<ADropDown> list) {

  //  //print(list.length);
  //   return list.map((e) => e.aName).toList();
  // }

  List<String> arrString(List<ADropDown> list) {
    list.forEach((element) {
      //print('Value: ${element.aName}');
    });
    return list.map((e) => e.aName).toList();
  }

  List<String> arrStringForProductList() {
    print("saranya"+customerProductList.length.toString());
    return customerProductList.map((e) {
            print('Value: ${e.aName} - ${e.productId}');
//return '${e.aName}';
      return '${e.aName} - ${e.productId}';
    }).toList();
  }

  // ADropDown find(String selected, List<ADropDown> list) {
  //   return list.firstWhere((element) => element.aName == selected);
  // }

  ADropDown find(String selected, List<ADropDown> list) {
    try {
      ADropDown result =
          list.firstWhere((element) => element.aName == selected);
      print("ID for $selected: ${result.aId}");
      return result;
    } catch (e) {
      print("ID not found for $selected");
      return list.first; // Provide a default value or handle it accordingly
    }
  }

  ADropDown findProduct(String selected, List<MCustomerProductItem> list) {
    return list.firstWhere(
        (element) => '${element.aName} - ${element.productId}' == selected);
  }

  fetchCustomerList() async {
    var response = await API.service.call(
        endPoint: EndPoint.getCustomerList,
        model: MCustomerList(),
        body: {'employee_id': AppController.user.employeeDetails!.id});
    if (response.isValidModel) {
      customerList.value = response.model!.data;
    }
  }

  fetchCustomerProductList(String cusID) async {
    var response = await API.service.call(
        endPoint: EndPoint.getCustomerProductItemList,
        model: MCustomerProductList.init(),
        body: {'customer_id': cusID}
        );
    if (response.isValidModel) {
      customerProductList.value = response.model!.data;
      print(customerProductList.length);
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
