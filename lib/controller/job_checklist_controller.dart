import 'package:eagle_pixels/api/ParamModel.dart';
import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/common/logger.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:eagle_pixels/model/check_list_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'job_detail_controller.dart';

class JobCheckListController extends GetxController {
  var checklistData = MCheckListResponse.init().obs;
  bool isLoading = false;

  List<MCheckListItem> get checkList {
    if (checklistData.value.data.length > 0) {
      return checklistData.value.data.first.list ?? [];
    } else
      return [];
  }

  List<MCheckListItem> get selectedlist {
    if (checklistData.value.data.length > 0) {
      return checklistData.value.data.first.selectedItems;
    } else
      return [];
  }

  final detail = Get.find<JobDetailController>();
  bool isOneTimeListRequested = false;

  fetchCheckList(String serviceID) async {
    var response = await API.service.call(
      needLoader: false,
      model: MCheckListResponse.init(),
      endPoint: EndPoint.checkList,
      body: {'service_id': serviceID},
    );
    this.checklistData.value = response.model!;

    update();
  }

  @override
  void onInit() async {
    await fetchCheckList(detail.detail.value.aServiceId.toString());
    super.onInit();
  }

  Future<String?> onSubmitJob(
      // ignore: non_constant_identifier_names
      {required String service_id}) async {
    Position position = await AppController.to.determinePosition();
    var param = await ParamSubmitJob(
            serviceID: service_id, checkList: this.selectedlist)
        .toJson();
    var response = await API.service.call(
      endPoint: EndPoint.submitJob,
      body: param,
    );
    hideLoading();
    if (response.isSuccess) {
      return null;
    } else {
      return response.message ?? kErrorMsg;
    }
  }

  Future<String?> onCompleteJob({
    required String requestID,
    required signature,
    required String feedback,
    required imagPath,
    required technicianSign,
    required String technicianComment,
    required String paymentMode,
    required String chemicalList,
    required String visitType,
    required String inspectionReport,
    required String preparation,
    required String areasInspected,
    required String remark,
    required String clientId,
    required String contactName,
    required String jobTitle,
    required String imageRemark,
  }) async {
    var param = await ParamCompleteJob(
      requestID: requestID,
      contactName: contactName,
      imageCaption: imageRemark,
      clientId: clientId,
      jobTitle: jobTitle,
      visitType: visitType,
      inspectionReport: inspectionReport,
      preparation: preparation,
      areasInspected: areasInspected,
      remark: remark,
      chemicalList: chemicalList,
      paymentMode: paymentMode,
      feedback: feedback,
      technicianComment: technicianComment,
      imagPath: imagPath,
      rating: "4",
      technicianSign: technicianSign,
      signature: signature,
    ).toJson();

    Logger.log('Complete Job', param.toString());
    print(param);
    isLoading = true;
    update();
    try {
      // Make API call
      var response = await API.service.call(
        endPoint: EndPoint.completeJob,
        body: param,
      );

      print(response);

      if (response.isSuccess) {
        detail.completedMessage = response.message ?? 'Job Completed';
        return null;
      } else {
        print(response.message);
        return response.message ?? kErrorMsg;
      }
    } catch (e) {
      print('Error: $e');
      return kErrorMsg;
    } finally {
      isLoading = false;
      update();
    }
  }
}
