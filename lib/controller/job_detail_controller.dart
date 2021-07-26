import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/controller/schedule_list_controller.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/reuse/Keys.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/model/schedule_job_detail_model.dart';
import 'package:eagle_pixels/model/site_model.dart';
import 'package:signature/signature.dart';

class JobDetailController extends GetxController {
  String completedMessage = '';
  var isRequestedDetailService = false;
  Rx<AJobDetail> detail = MJobDetail().obs;
  // var arrSites = <MSite>[].obs;
  // late Rx<MSite?> selectedSite = Rx(null);

  final signatureController = SignatureController().obs;
  final Rx<double> starRate = 0.toDouble().obs;
  final RxString feedback = ''.obs;
  final RxString engineerFeedback = ''.obs;

  @override
  void onInit() {
    // fetchSite();
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

  // fetchSite() async {
  //   var response = await API.service.call(
  //       model: MSiteResponse(),
  //       endPoint: EndPoint.site,
  //       body: {K.service_id: '2'}
  //       );
  //
  //   if (response.isValidModel) {
  //     arrSites.value = response.model!.data!;
  //     selectedSite.value = arrSites.first;
  //   }
  // }
}
