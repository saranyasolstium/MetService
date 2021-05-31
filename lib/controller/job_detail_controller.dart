import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/reuse/Keys.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/model/schedule_job_detail_model.dart';
import 'package:eagle_pixels/model/site_model.dart';

class JobDetailController extends GetxController {
  Rx<AJobDetail> detail = MJobDetail().obs;
  var arrSites = <MSite>[].obs;
  late Rx<MSite?> selectedSite = Rx(null);
  @override
  void onInit() {
    // fetchSite();
    super.onInit();
    Future.delayed(Duration(microseconds: 100), () {
      fetchDetail();
    });
  }

  fetchDetail() async {
    var response = await API.service.call(
        model: MScheduleJobDetail(),
        endPoint: EndPoint.jobdetail,
        body: {K.job_id: '1'} //temp
        );
    if (response.isValidModel) {
      detail.value = response.model!.data!;
    }
  }

  fetchSite() async {
    var response = await API.service.call(
        model: MSiteResponse(),
        endPoint: EndPoint.site,
        body: {K.service_id: '2'} //temp
        );

    if (response.isValidModel) {
      arrSites.value = response.model!.data!;
      selectedSite.value = arrSites.first;
    }
  }
}
