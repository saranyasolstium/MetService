import 'dart:convert';

import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/common/constant.dart';
import 'package:eagle_pixels/common/logger.dart';
import 'package:eagle_pixels/common/snackbar.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/reuse/Keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/model/schedule_job_detail_model.dart';
import 'package:signature/signature.dart';
import 'package:toast/toast.dart';

class JobDetailController extends GetxController {
  String completedMessage = '';
  var isRequestedDetailService = false;
  Rx<AJobDetail> detail = MJobDetail().obs;
  // var arrSites = <MSite>[].obs;
  // late Rx<MSite?> selectedSite = Rx(null);

  final signatureController = SignatureController().obs;
  final signatureTechnicianController = SignatureController().obs;
  final Rx<double> starRate = 0.toDouble().obs;
  final RxString feedback = ''.obs;
  final RxString engineerFeedback = ''.obs;
  final RxString areasInspected = ''.obs;
  final RxString other = ''.obs;
  String? selectedPaymentMode = 'Bank Transfer';
  final RxString selectedVisitType = 'Routine'.obs;
  List<List<String>> selectedValues = [];
  RxBool isOtherChecked = false.obs;
  RxList<String> itemsInspected = <String>[].obs;

  final RxString otherInspected = ''.obs;

  final RxString remark = ''.obs;
  final RxString visitType = ''.obs;
  final RxString clientId = ''.obs;
  final RxString contactName = ''.obs;
  final RxString jobTitle = ''.obs;

  final RxMap<String, String> selectedCheckboxValues = <String, String>{}.obs;
  final RxString preparation = ''.obs;
  final RxList<Map<String, String>> enteredValues = <Map<String, String>>[].obs;

  set _isOtherChecked(bool _isOtherChecked) {}
  @override
  void onInit() {
    super.onInit();
  }

  fetchDetail({required String jobID}) async {
    var response = await API.service.call(
        model: MScheduleJobDetail(),
        endPoint: EndPoint.jobdetail,
        body: {K.job_id: jobID});
    if (response.isValidModel) {
      detail.value = response.model!.data!;
    }
  }

  Future<void> updateJob(String requestID) async {
    Map<String, String> convertedMap = {};

    selectedCheckboxValues.forEach((key, value) {
      convertedMap['"$key"'] = '"$value"';
    });
    var bytes = await signatureController.value.toPngBytes();
    var techBytes = await signatureTechnicianController.value.toPngBytes();

    var requestBody = {
      "RequestID": requestID,
      "rating": 0,
      "contact_name": contactName.value,
      "customer_comment": engineerFeedback.value,
      "employee_comment": feedback.value,
      "payment_mode": selectedPaymentMode,
      "chemical_list": remark,
      "visit_type": selectedVisitType.value,
      "client_id": clientId.value,
      "job_title": jobTitle.value,
      "areas_inspected": areasInspected.value,
      "inspection_report": convertedMap.toString(),
      "preparation": preparation.value,
      "signature": bytes != null ? base64Encode(bytes) : "",
      "employee_sign": techBytes != null ? base64Encode(techBytes) : ""
    };

    Logger.log('Request Body:', requestBody.toString());

    try {
      var response = await API.service.call(
        endPoint: EndPoint.updateJob,
        body: requestBody,
      );

      if (response.isSuccess) {
        SnackbarService.showSnackbar(
            "", "Service Request Update successfully.");
      } else {
        // Toast.show(
        //   response.message.toString(),
        //   backgroundColor: Colors.white,
        //   textStyle: TextStyle(fontSize: 16.0, color: Colors.black),
        // );
      }
    } catch (e) {
      // Handle any exceptions that might occur
      print('Error occurred: $e');
    } finally {}
  }

  Future<void> getJobUpdate(String requestID) async {
    Constants.requestId = requestID; // Assign the request ID
    try {
      var response = await API.service.call(
        endPoint: EndPoint.getJobUpdate,
      );

      if (response.isSuccess) {
        // Parse the response data
        var responseData = response.map;

        var data = responseData['data'];

        contactName.value = data['contact_name'];
        clientId.value = data['client_id'];
        jobTitle.value = data['job_title'];
        selectedVisitType.value = data['visit_type'];

        //Inspected for
        selectedCheckboxValues['Cockroach'] =
            data['inspect_report']['cockroach'] ?? "";
        selectedCheckboxValues['Mosquito'] =
            data['inspect_report']['mosquito'] ?? "";
        selectedCheckboxValues['Common Ant'] =
            data['inspect_report']['common_ant'] ?? "";
        selectedCheckboxValues['Housefly'] =
            data['inspect_report']['housefly'] ?? "";
        selectedCheckboxValues['Rodent'] =
            data['inspect_report']['rodent'] ?? "";
        selectedCheckboxValues['Bedbug'] =
            data['inspect_report']['bedbug'] ?? "";
        selectedCheckboxValues['Subterranean Termite'] =
            data['inspect_report']['subterranean_termite'] ?? "";
        selectedCheckboxValues['Fleas'] = data['inspect_report']['fleas'] ?? "";

        if (data['inspect_report']['others'] != null) {
          isOtherChecked.value = true;
        } else {
          isOtherChecked.value = false;
        }
        if (data['inspect_report']['others'] != null &&
            data['inspect_report']['others'].contains('-')) {
          List<String> splitValues =
              data['inspect_report']['others'].split('-');
          selectedCheckboxValues['Other'] = splitValues[0];
          String otherValueDescription =
              splitValues.length > 1 ? splitValues[1] : "";
          otherInspected.value = otherValueDescription;
        } else {
          selectedCheckboxValues['Other'] =
              data['inspect_report']['others'] ?? "";
        }

        selectedCheckboxValues.forEach((item, values) {
          int index = itemsInspected.indexOf(item);
          if (index != -1) {
            List<String> valueList = values.split(',');
            selectedValues[index] = valueList;
          }
        });
        print('Bound Values1: ${selectedCheckboxValues.toString()}');

        //Preparation
        enteredValues.clear();
        if (data['service_preparation'] != null) {
          var servicePreparation = data['service_preparation'];
          enteredValues.add({
            "Type": servicePreparation['type'],
            "Method": servicePreparation['method'],
            "Quantity": servicePreparation['quantity'],
          });
        }
        areasInspected.value = data['areas_inspected'];
        remark.value = data['chemical_list'];
        selectedPaymentMode = data['payment_mode'];

        engineerFeedback.value = data['customer_comment'];
        feedback.value = data['employee_comment'];

        update();
      } else {
        // Handle the error response
        print('Error: ${response.message}');
      }
    } catch (e) {
      // Handle any exceptions that might occur
      print('Error occurred: $e');
    }
  }
}
