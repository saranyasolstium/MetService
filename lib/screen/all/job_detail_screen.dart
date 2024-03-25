import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/common/currency_convertor.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/controller/job_detail_controller.dart';
import 'package:eagle_pixels/controller/schedule_list_controller.dart';
import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:eagle_pixels/main.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/reuse/Keys.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:eagle_pixels/reuse/network_image_view.dart';
import 'package:eagle_pixels/reuse/shared_preference_helper.dart';
import 'package:eagle_pixels/screen/schedule/job_checklist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:intl/intl.dart';

import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../colors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:eagle_pixels/common/logger.dart';

// ignore: must_be_immutable
extension JobDetailAction on JobDetailScreen {
  onStartJob() async {
    try {
      showLoading();
      var res = await schedule.onStartJob(service_id: detail.aServiceId ?? '0');
      hideLoading();
      String status = res[K.status] ?? '';
      String error = res['error'] ?? '';
      String message = res['message'] ?? res['error'] ?? kErrorMsg;

      if (isSuccess(status) || error == K.already_checkIn) {
        schedule.reloadList();
        //scheduled_job_details_model.dart
        Get.to(() => JobCheckListScreen(detail.aServiceId ?? '0'));
      } else {
        Toast.show(message,
            backgroundColor: Colors.white,
            textStyle: TextStyle(color: Colors.black, fontSize: 16.0));
      }
    } catch (e) {
      Toast.show('$e',
          backgroundColor: Colors.white,
          textStyle: TextStyle(color: Colors.black, fontSize: 16.0));
      print(e);
    }
  }
}

class JobDetailScreen extends StatelessWidget {
  final JobDetailController controller = Get.put(JobDetailController());
  final ScheduleListController schedule = Get.find();
  // final bool isNeedContainer;
  final bool isNeedStartJob;
  final String jobID;
  JobDetailScreen({this.isNeedStartJob = false, required this.jobID});

  // late Rx<PDFDocument> document;
  AJobDetail get detail {
    return controller.detail.value;
  }

  Future<String> convertAndDisplayAmount(String amount) async {
    try {
      double amountInSGD = double.tryParse(amount) ?? 0.0;
      String? toCurrency =
          await SharedPreferencesHelper.instance.readCurrencyCode();
      String? currencySymbol =
          await SharedPreferencesHelper.instance.readCurrencySymbol();

      print(toCurrency);
      double result = await CurrencyConversionService()
          .convertAmount(amountInSGD, 'SGD', toCurrency!);
      return '$currencySymbol $result';
    } catch (error) {
      print('Error converting amount: $error');
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.isRequestedDetailService) {
      Future.delayed(Duration(milliseconds: 100), () {
        controller.isRequestedDetailService = true;
        controller.fetchDetail(jobID: jobID);
      });
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Obx(
              () => Container(
                color: Color(0xff757575),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Container(
                    // padding: EdgeInsets.only(top: 30.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 13.dynamic,
                        ),
                        Center(
                          child: this.cancelButton,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.dynamic, horizontal: 20.dynamic),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Job Details',
                                    style: TextStyle(
                                        color: Colour.appBlue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.dynamic),
                                  ),
                                  SizedBox(
                                    height: 21.dynamic,
                                  ),
                                  // this.cameraInfoView,
                                  // SizedBox(height: 20.dynamic),
                                  // Text(
                                  //   'Ticket Information:',
                                  //   style: TextStyle(
                                  //       color: Colour.appBlue,
                                  //       fontWeight: FontWeight.w400,
                                  //       fontSize: 16.dynamic),
                                  // ),
                                  // SizedBox(height: 10.dynamic),
                                  // this.tickInformationView,
                                  // SizedBox(height: 30.dynamic),
                                  Text(
                                    'Customer Information:',
                                    style: TextStyle(
                                        color: Colour.appBlue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.dynamic),
                                  ),
                                  this.customerInformationView,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.only(bottom: 10.dynamic),
                                        child: Text(
                                          'Site Address:',
                                          style: TextStyle(
                                              color: Colour.appDarkGrey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12.dynamic),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          String query = Uri.encodeComponent(
                                              detail.aCombinedAddress ?? '');
                                          String googleUrl =
                                              "https://www.google.com/maps/search/?api=1&query=$query";
                                          if (await canLaunch(googleUrl)) {
                                            await launch(googleUrl);
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 20.dynamic,
                                              bottom: 10.dynamic),
                                          child: Icon(
                                            Icons.location_on,
                                            size: 25,
                                            color: Colour.appDarkGrey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Text(
                                    detail.aCombinedAddress ?? 'NA',
                                    style: TextStyle(
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.dynamic),
                                  ),
                                  // this.warrantyInfo,
                                  SizedBox(height: 30.dynamic),
                                  Text(
                                    'Service information:',
                                    style: TextStyle(
                                        color: Colour.appBlue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.dynamic),
                                  ),
                                  this.serviceReportView
                                  
                                ],
                              ),
                            ),
                          ),
                        ),
                        // this.bottomView,
                        this.isNeedStartJob ? this.bottomView : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AppController.to.defaultLoaderView(),
          ],
        ),
      ),
    );
  }
}

extension JobDetailWidgets on JobDetailScreen {
  Widget get cancelButton {
    return CircleAvatar(
      backgroundColor: Colour.appLightGrey,
      radius: 23.dynamic,
      child: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.close,
          size: 23.dynamic,
          color: Colour.appBlue,
        ),
      ),
    );
  }

  Widget get customerInformationView {
    return Column(
      children: [
        SizedBox(height: 10.dynamic),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionImageView(
                'Customer:',
                detail.aCustomerName ?? 'NA',
                detail.aCustomerImage ?? 'NA',
                kUserPlaceholder),
            // JobDetailTitleDescriptionView('Item:', detail.aItem),
          ],
        ),
        SizedBox(height: 15.dynamic),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView('Email:', detail.aEmail ?? 'NA'),
            JobDetailTitleDescriptionView('Phone No:', detail.aPhoneNo ?? 'NA'),
          ],
        ),
      ],
    );
  }

  Widget get serviceReportView {
    return Column(
      children: [
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Service Name:', detail.aServiceName ?? 'NA'),
            JobDetailTitleDescriptionView(
                'SubService Name:', detail.aSubServiceName ?? 'NA'),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Service Type:', detail.aTeamName ?? 'NA'),
          ],
        ),
        //  SizedBox(
        //   height: 20.dynamic,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     JobDetailTitleDescriptionView(
        //         'Type:', detail.aType ?? 'NA'),
        //   ],
        // ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Service date:', detail.aBookingDate ?? 'NA'),
            JobDetailTitleDescriptionView(
                'Schedule Time:', detail.aBookingTime ?? 'NA'),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            JobDetailAmountDescriptionView(
              'Service Amount',
              () async =>
                  await convertAndDisplayAmount(detail.aBookingAmount!) ?? "NA",
            ),
          ],
        ),
      ],
    );
  }

  Widget get bottomView {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 19.dynamic,
          left: 17.dynamic,
          right: 17.dynamic,
          bottom: 10.dynamic,
        ),
        child: Column(
          children: [
            Obx(
              () => Text(
                DateFormat('hh:mm a  |  dd MMMM yyyy')
                    .format(TimerController.to.currentDate.value),

                // Jiffy(TimerController.to.currentDate.value)
                //     .format(pattern: 'hh:mm a  |  do MMMM yyyy'),

                style: TextStyle(
                  fontSize: 14.dynamic,
                  fontWeight: FontWeight.w600,
                  color: HexColor.fromHex("333333"),
                ),
              ),
            ),
            SizedBox(
              height: 19.dynamic,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colour.appBlue,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.dynamic),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  this.onStartJob();
                },
                child: Text(
                  ((detail.aEnginnerStatus ?? 0) == 2 ||
                          (detail.aEnginnerStatus ?? 0) == 1)
                      ? 'Resume Job'
                      : 'Start Job',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.dynamic,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobDetailTitleDescriptionView extends StatelessWidget {
  final String title;
  final String? description;
  JobDetailTitleDescriptionView(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colour.appDarkGrey,
                fontWeight: FontWeight.normal,
                fontSize: 12.dynamic),
          ),
          SizedBox(
            height: 4.dynamic,
          ),
          Text(
            description ?? 'NA',
            style: TextStyle(
                color: Colour.appBlack,
                fontWeight: FontWeight.w600,
                fontSize: 14.dynamic),
          ),
        ],
      ),
    );
  }
}

class JobDetailAmountDescriptionView extends StatelessWidget {
  final String title;
  final Future<String?> Function() descriptionFutureFunction;

  JobDetailAmountDescriptionView(this.title, this.descriptionFutureFunction);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colour.appDarkGrey,
              fontWeight: FontWeight.normal,
              fontSize: 12.dynamic,
            ),
          ),
          SizedBox(
            height: 4.dynamic,
          ),
          FutureBuilder<String?>(
            future: descriptionFutureFunction(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final data = snapshot.data;
                if (data != null) {
                  return Text(
                    data,
                    style: TextStyle(
                      color: Colour.appBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.dynamic,
                    ),
                  );
                } else {
                  return Text('NA');
                }
              } else if (snapshot.hasError) {
                return Text('NA');
              } else {
                return Text('NA');
              }
            },
          ),
        ],
      ),
    );
  }
}

class JobDetailTitleDescriptionImageView extends StatelessWidget {
  final String title;
  final String? description;
  final String? image;
  final String placeholder;
  JobDetailTitleDescriptionImageView(
      this.title, this.description, this.image, this.placeholder);

  @override
  Widget build(BuildContext context) {
    print(image);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colour.appDarkGrey,
                fontWeight: FontWeight.w400,
                fontSize: 12.dynamic),
          ),
          SizedBox(
            height: 4.dynamic,
          ),
          Row(
            children: [
              Container(
                width: 24.dynamic,
                height: 24.dynamic,
                alignment: Alignment.center,
                child: Image.asset('images/user.png'),
                // child: SvgPicture.network(
                //   image!,
                //   placeholderBuilder: (BuildContext context) =>
                //       Image.asset('images/user.png'),
                // ),
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.blue,
                //   ),
                //   borderRadius: BorderRadius.circular(37.5.dynamic),
                // ),
              ),
              SizedBox(
                width: 7.dynamic,
              ),
              Text(
                description ?? 'NA',
                style: TextStyle(
                    color: Colour.appBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.dynamic),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
