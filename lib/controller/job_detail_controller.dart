import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/reuse/Keys.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/model/schedule_job_detail_model.dart';
import 'package:signature/signature.dart';

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
  String? selectedVisitType = 'Routine';
  List<List<String>> selectedValues = [];
  bool isOtherChecked = false;
    late List<String> itemsInspected;

  final RxString otherInspected = ''.obs;

  final RxString remark = ''.obs;
  final RxString visitType = ''.obs;

  final Map<String, String> selectedCheckboxValues = {};
  final RxString preparation = ''.obs;
  List<Map<String, String>> enteredValues = [];

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
}
