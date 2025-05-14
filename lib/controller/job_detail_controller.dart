import 'dart:convert';
import 'dart:typed_data';
import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/common/constant.dart';
import 'package:eagle_pixels/common/logger.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/model/schedule_job_detail_model.dart';
import 'package:eagle_pixels/reuse/Keys.dart';
import 'package:eagle_pixels/reuse/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:http/http.dart' as http;

class JobDetailController extends GetxController {
  String completedMessage = '';
  var isRequestedDetailService = false;
  Rx<AJobDetail> detail = MJobDetail().obs;
  TextEditingController contactNameController = TextEditingController();
  TextEditingController clientIdController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController otherInspectedController = TextEditingController();

  final signatureController = SignatureController().obs;
  final signatureTechnicianController = SignatureController().obs;
  final Rx<double> starRate = 0.toDouble().obs;
  final RxString feedback = ''.obs;
  final RxString engineerFeedback = ''.obs;
  final RxString areasInspected = ''.obs;
  final RxString other = ''.obs;
  final RxString customerSignatureUrl = ''.obs;
  final RxString technicianSignUrl = ''.obs;
  String concatenatedImages = '';

  String? selectedPaymentMode = 'Bank Transfer';
  RxString selectedVisitType = 'Routine'.obs;
  RxString imageCaption = ''.obs;
  List<List<String>> selectedValues = [];
  RxBool isOtherChecked = false.obs;
  RxList<String> itemsInspected = <String>[].obs;
  final Rx<Uint8List?> imageBytes = Rx<Uint8List?>(null);

  final RxString remark = ''.obs;
  final RxString visitType = ''.obs;
  final String? attachedUrl = "";

  final RxMap<String, String> selectedCheckboxValues = <String, String>{}.obs;
  final RxString preparation = ''.obs;
  final RxList<Map<String, String>> enteredValues = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchDetail({required String jobID}) async {
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
    var preparationValue =
        preparation.value.toString() == "[]" ? "" : preparation.value;

    print('varshan223 ${preparationValue}');
    var bytes = await signatureController.value.toPngBytes();
    var techBytes = await signatureTechnicianController.value.toPngBytes();

    var requestBody = {
      "RequestID": requestID,
      "after_service_img": concatenatedImages,
      "after_service_images_caption": imageCaption.value,
      "rating": 0,
      "contact_name": contactNameController.text,
      "customer_comment": engineerFeedback.value,
      "employee_comment": feedback.value,
      "payment_mode": selectedPaymentMode,
      "chemical_list": remark,
      "visit_type": selectedVisitType.value,
      "client_id": clientIdController.text,
      "job_title": jobTitleController.text,
      "areas_inspected": areasInspected.value,
      "inspection_report": convertedMap.toString(),
      "preparation": preparationValue,
      "signature": bytes != null ? base64Encode(bytes) : "",
      "employee_sign": techBytes != null ? base64Encode(techBytes) : "",
    };

    Logger.log('Request Body:', requestBody.toString());

    try {
      var response = await API.service.call(
        endPoint: EndPoint.updateJob,
        body: requestBody,
      );

      if (response.isSuccess) {
        print("Service Request Update successfully.");
      } else {
        print('Error: ${response.message}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> updatePreparation(String requestID) async {
    var requestBody = {
      "RequestID": requestID,
      "preparation": jsonEncode(enteredValues),
    };

    Logger.log('Request Body:', requestBody.toString());

    try {
      var response = await API.service.call(
        endPoint: EndPoint.updateJob,
        body: requestBody,
      );

      if (response.isSuccess) {
        print("Service preparation Update successfully.");
      } else {
        print('Error: ${response.message}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<String?> getSignedUrl(String? key) async {
    if (key == null || key.trim().isEmpty) return null;

    // Take only the first key if comma-separated

    // Construct GET URL with query param
    String url = "https://met.solstium.net/api/v1/signed_url?key=$key";
    String? token = await SharedPreferencesHelper.getToken();

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        print('hdsbhdshh $jsonData');
        return jsonData['data']?.toString(); // Return signed URL
      } else {
        print('GET failed with status: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('GET request error: $error');
      return null;
    }
  }

  Future<void> getJobUpdate(String requestID) async {
    Constants.requestId = requestID;
    enteredValues.clear();
    try {
      var response = await API.service.call(
        endPoint: EndPoint.getJobUpdate,
      );

      if (response.isSuccess) {
        var responseData = response.map;
        var data = responseData['data'];

        contactNameController.text = data['contact_name'] ?? "";
        clientIdController.text = data['client_id'] ?? "";
        jobTitleController.text = data['job_title'] ?? "";
        selectedVisitType.value = data['visit_type'] ?? "Routine";

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
          selectedCheckboxValues['Other'] =
              data['inspect_report']['others'] ?? "";
          otherInspectedController.text =
              data['inspect_report']['others_value'] ?? "";
          ;
        } else {
          isOtherChecked.value = false;
        }
        // if (data['inspect_report']['others'] != null &&
        //     data['inspect_report']['others'].contains('-')) {
        //   List<String> splitValues =
        //       data['inspect_report']['others'].split('-');
        //   selectedCheckboxValues['Other'] = splitValues[0];
        //   String otherValueDescription =
        //       splitValues.length > 1 ? splitValues[1] : "";
        //   otherInspectedController.text = otherValueDescription;
        // } else {
        //   selectedCheckboxValues['Other'] =
        //       data['inspect_report']['others'] ?? "";
        // }

        selectedCheckboxValues.forEach((item, values) {
          int index = itemsInspected.indexOf(item);
          if (index != -1) {
            List<String> valueList = values.split(',');
            selectedValues[index] = valueList;
          }
        });

        // Now, let's handle the service_preparation part
        print('saranya2345');

        var servicePreparation = data['service_preparation'] ?? [];

        print(servicePreparation);
        if (servicePreparation.isNotEmpty) {
          servicePreparation.forEach((service) {
            String type = service['type'] ?? "";
            String method = service['method'] ?? "";
            String quantity = service['quantity'] ?? "";
            print("Service Type: $type, Method: $method, Quantity: $quantity");
            enteredValues.add({
              "Type": type,
              "Method": method,
              "Quantity": quantity,
            });
          });
        }

        areasInspected.value = data['areas_inspected'] ?? "";
        remark.value = data['chemical_list'] ?? "";
        selectedPaymentMode = data['payment_mode'] ?? "Bank Transfer";
        engineerFeedback.value = data['customer_comment'] ?? "";
        feedback.value = data['employee_comment'] ?? "";

        // Download and set the signature image
        await downloadImage(data['customer_sign']);
        await downloadImageTech(data['employee_sign']);
        update();
      } else {
        print('Error: ${response.message}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> downloadImage(String imageUrl) async {
    print('Starting image download...');
    try {
      var response = await API.service.call(
        endPoint: EndPoint.downloadImage,
        body: {'image': imageUrl},
      );

      if (response.isSuccess) {
        var responseData = response.map;
        var data = responseData['data'];
        print(data);
        customerSignatureUrl.value = data;
        update();
      } else {
        print('Error: ${response.message}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> downloadImageTech(String imageUrl) async {
    print('Starting image download...');
    try {
      var response = await API.service.call(
        endPoint: EndPoint.downloadImage,
        body: {'image': imageUrl},
      );

      if (response.isSuccess) {
        var responseData = response.map;
        var data = responseData['data'];
        print(data);
        technicianSignUrl.value = data;
        update();
      } else {
        print('Error: ${response.message}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
