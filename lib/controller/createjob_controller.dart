import 'dart:math';

import 'package:eagle_pixels/common/snackbar.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/model/avaiable_engineer_model.dart';
import 'package:eagle_pixels/model/customer_product_model.dart';
import 'package:eagle_pixels/model/oppoinment_model.dart';
import 'package:eagle_pixels/model/sebservice_response_model.dart';
import 'package:eagle_pixels/model/service_model.dart';
import 'package:eagle_pixels/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
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

  TextEditingController serviceOrderCtrl = TextEditingController();

  var customerList = <MCustomerItem>[].obs;
  var customerProductList = <MCustomerProductItem>[].obs;
  var serviceTypeList = <MServiceType>[].obs;
  var oppoinmentList = <MOppointment>[].obs;
  var productList = <MCustomerProduct>[].obs;
  var serviceList = <MService>[].obs;
  var subServiceList = <MSubService>[].obs;
  var avaiableEngList = <MAvailableEngineer>[].obs;
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController serviceAmountCtrl = TextEditingController();
  final TextEditingController attentionCtrl = TextEditingController();
  final TextEditingController referralNameCtrl = TextEditingController();
  final TextEditingController billingFreqCtrl = TextEditingController();
  final TextEditingController estimationDurationCtrl = TextEditingController();
  final TextEditingController decisionMakerCtrl = TextEditingController();
  final TextEditingController whomtoSeeCtrl = TextEditingController();
  final TextEditingController servicePremiseCtrl = TextEditingController();
  final TextEditingController subjectCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();
  final TextEditingController treatmentOtherCtrl = TextEditingController();
  final TextEditingController freqOtherCtrl = TextEditingController();
  final TextEditingController sourceOtherCtrl = TextEditingController();

  int? customerID = 46;

  String? date = "";
  String? startTime = "";
  String? endTime = "";

  int serviceId = 7;
  int subServiceID = 0;
  String selectedAppointmentId = "";
  String selectedProductId = "";
  String selectedDepartId = "";
  String selectedPriorityId = "";
  String selectedStatusId = "";
  String selectedCustomerType = "";
  String selectedTreatment = "";
  String selectedfrequency = "";
  String selectedInfestation = "";
  String selectedSource = "";
  String selectedPreparation = "";
  String selectedBillingType = "";

  void setSelected(String value) {
    valueOfDrop.value = value;
  }

  void updateCheckboxState(MAvailableEngineer engineer, bool isChecked) {
    engineer.isChecked = isChecked;
    update();
  }

  @override
  void onInit() async {
    await fetchCustomerList();
    await fetchProductRequest();
    await fetchServiceRequest();
    serviceOrderCtrl.text = generateRandomSRNumber(8);
    print(serviceOrderCtrl.text);
    selectedfrequency = "";

    // await fetchServiceType();
    super.onInit();
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay startTimeOfDay = TimeOfDay.now();
  TimeOfDay endTimeOfDay = TimeOfDay.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      date = '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
      print(date);
      update(); // Notify observers that the variable has changed
    }
  }

  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTimeOfDay : endTimeOfDay,
    );
    if (picked != null) {
      if (isStartTime) {
        startTimeOfDay = picked;
        startTime = formatTimeOfDay(startTimeOfDay);
      } else {
        endTimeOfDay = picked;
        endTime = formatTimeOfDay(endTimeOfDay);
        fetchAvailableEngineer();
      }
      print(startTime);
      print(endTime);
      update();
    }
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final DateTime dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
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

  int? getServiceIdFromName(String name) {
    MService? service = serviceList.firstWhere(
      (serviceItem) => serviceItem.serviceName == name,
    );
    serviceId = service.id;
    update();
    return service.id;
  }

  int? getSubServiceIdFromName(String serviceName) {
    for (var subService in subServiceList) {
      if (subService.serviceName == serviceName) {
        subServiceID = subService.id;
        return subService.id;
      }
    }
    return null;
  }

  int? getAppoinmentFromName(String serviceName) {
    for (var appointment in oppoinmentList) {
      if ('${appointment.bookingDate} - ${appointment.address}' ==
          serviceName) {
        // Update selectedAppointmentId within the function
        selectedAppointmentId = appointment.id.toString();
        print(appointment.id);
        return appointment.id;
      }
    }
    return null;
  }

  int? getProductFromName(String name) {
    for (var product in productList) {
      if (product.name == name) {
        selectedProductId = product.id.toString();
        print(selectedProductId);
        return product.id;
      }
    }
    return null;
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

  fetchCustomerProductList() async {
    var response = await API.service.call(
      endPoint: EndPoint.getCustomerProductItemList,
      model: MCustomerProductList.init(),
    );
    if (response.isValidModel) {
      customerProductList.value = response.model!.data;
      print(customerProductList.length);
    } else {
      customerProductList.value = [];
    }
  }

  fetchOppoinmentRequest(String cusID) async {
    var response = await API.service.call(
      endPoint: EndPoint.oppoinmentList,
      model: MOppoinmentTypeResponse.fromJson({}),
      body: {'requester_id': cusID},
    );
    if (response.isValidModel) {
      oppoinmentList.value = response.model!.data;
    } else {
      oppoinmentList.value = [];
    }
  }

  fetchProductRequest() async {
    var response = await API.service.call(
      endPoint: EndPoint.customerProduct,
      model: MCustomerProductResponse.fromJson({}),
    );
    if (response.isValidModel) {
      productList.value = response.model!.data;
    } else {
      productList.value = [];
    }
  }

  fetchSaleProductRequest(String cusID) async {
    var response = await API.service.call(
      endPoint: EndPoint.productSales,
      model: MOppoinmentTypeResponse.fromJson({}),
      body: {'requester_id': cusID},
    );
    if (response.isValidModel) {
      oppoinmentList.value = response.model!.data;
    } else {
      oppoinmentList.value = [];
    }
  }

  // In your fetchServiceRequest method
  Future<void> fetchServiceRequest() async {
    try {
      var response = await API.service.call(
        endPoint: EndPoint.serviceLists,
        model: MServiceResponse.fromJson({}),
      );
      if (response.isValidModel) {
        serviceList.value = response.model!.data;
      } else {
        serviceList.value = [];
      }
    } catch (e) {
      print('Error fetching service data: $e');
    }
  }

  fetchAvailableEngineer() async {
    var requestBody = {
      "service_id": serviceId,
      "date": "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
      "starttime": startTime,
      "endtime": endTime,
      "department": "",
      "service": serviceId
    };

    print('Request Body: $requestBody');

    var response = await API.service.call(
      endPoint: EndPoint.availableEngineer,
      model: MAvailableEngineerResponse.fromJson({}),
      body: requestBody,
    );

    if (response.isValidModel) {
      avaiableEngList.value = response.model!.data;
      update();
    } else {
      avaiableEngList.value = [];
      update();
    }
  }

  createJob() async {
    var requestBody = {
      "requester_id": customerID,
      "product_id": selectedProductId,
      "address": addressCtrl.text,
      "department_id": selectedDepartId,
      "project_id": "",
      "sales_order_id": "",
      "service_type_id": "",
      "service_amount": serviceAmountCtrl.text,
      "service_id": serviceId,
      "subservice_id": subServiceID,
      "service_cover": "",
      "service_other": "",
      "treatment_method": selectedTreatment,
      "treatment_other": treatmentOtherCtrl.text,
      "service_frequency": selectedfrequency,
      "service_freq_other": freqOtherCtrl.text,
      "business_source": selectedSource,
      "busines_source_other": sourceOtherCtrl.text,
      "degree_infestation": selectedInfestation,
      "billing_type": selectedBillingType,
      "referral_name": referralNameCtrl.text,
      "estimation_first_service": estimationDurationCtrl.text,
      "decision_maker": decisionMakerCtrl.text,
      "see_on_site": whomtoSeeCtrl.text,
      "service_premise_address": servicePremiseCtrl.text,
      "billing_frequency": billingFreqCtrl.text,
      "preparation": "",
      "date": '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
      "service_time_start": startTime,
      "service_time_end": endTime,
      "new_engineer_id": "362",
      "subject": subjectCtrl.text,
      "description": descriptionCtrl.text,
      "source": 2,
      "priority": selectedPriorityId,
      "status": selectedStatusId,
      "customer_type": selectedCustomerType,
      "service_order_id": serviceOrderCtrl.text,
      "attention": attentionCtrl.text,
      "oppoinment_request_id": selectedAppointmentId,
      "type": ""
    };

    print('Request Body: $requestBody');

    var response = await API.service.call(
      endPoint: EndPoint.createJob,
      body: requestBody,
    );

    if (response.isSuccess) {
      SnackbarService.showSnackbar("", "Service Request Created successfully.");
      Get.offAll(HomeScreen());
    } else {
      Toast.show(
        response.message.toString(),
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16.0, color: Colors.black),
      );
    }

    print(response.isSuccess);

    // Handle response here
  }

  // In your fetchSubServiceRequest method
  Future<void> fetchSubServiceRequest(int serviceId) async {
    try {
      var response = await API.service.call(
        endPoint: EndPoint.subServicelists,
        model: MSubServiceResponse.fromJson({}),
        body: {'service_id': serviceId},
      );
      if (response.isValidModel) {
        subServiceList.value = response.model!.data;
        print(subServiceList.value.length);
      } else {
        subServiceList.value = [];
      }
    } catch (e) {
      print('Error fetching service data: $e');
    }
  }

  String generateRandomSRNumber(int length) {
    String prefix = 'SR';

    final Random random = Random();
    final int min = 100000; // Minimum 6-digit number
    final int max = 999999; // Maximum 6-digit number
    final int randomNumber = min + random.nextInt(max - min);

    String generatedNumber = '$prefix$randomNumber';

    if (generatedNumber.length < length) {
      generatedNumber += '0' * (length - generatedNumber.length);
    } else if (generatedNumber.length > length) {
      generatedNumber = generatedNumber.substring(0, length);
    }

    return generatedNumber;
  }
  // fetchServiceType() async {
  //   var response = await API.service.call(
  //     endPoint: EndPoint.serviceTypeList,
  //     model: MServiceTypeResponse(),
  //   );
  //   if (response.isValidModel) {
  //     serviceTypeList.value = response.model!.data;
  //   } else {
  //     serviceTypeList.value = [];
  //   }
  // }

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
