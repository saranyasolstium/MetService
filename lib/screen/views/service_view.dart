import 'dart:io';

import 'package:eagle_pixels/controller/attendance_controller.dart';
import 'package:eagle_pixels/controller/schedule_list_controller.dart';
import 'package:eagle_pixels/main.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:eagle_pixels/reuse/date_manager.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:eagle_pixels/reuse/network_image_view.dart';
import 'package:eagle_pixels/reuse/shared_preference_helper.dart';
import 'package:eagle_pixels/screen/all/job_detail_screen.dart';
import 'package:eagle_pixels/screen/job_history/pdf_viewer.dart';

import 'package:flutter/material.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../colors.dart';

extension ServiceViewAction on ServiceView {
  onStopJob() async {
    showLoading();
    await schedule.onStopJob(service_id: item.aServiceID ?? '0');
    hideLoading();
    await AttendanceController.to.fetchAttendanceStatus();
    schedule.update();
    navigator!
        .popUntil((route) => route.settings.name == NavPage.scheduleScreen);
  }
}

class ServiceView extends StatelessWidget {
  final ScheduleListController schedule = Get.find();
  ServiceView({
    required this.item,
    this.buttonTitle,
    this.isNeedDetail = true,
    this.detailCustomAction,
    required this.onJob,
    this.isNeedStatus = false,
    required this.onSeeDetail,
    this.isNeedStartJob = false,
    this.isNeedScheduledTime = false,
  });
  final bool isNeedStatus;
  final bool isNeedDetail;
  final bool isNeedScheduledTime;
  final String? buttonTitle;
  final Function onSeeDetail;
  final Function onJob;
  final AServiceItem item;
  final bool isNeedStartJob;
  final Function? detailCustomAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16.dynamic,
        left: 16.dynamic,
        bottom: 13.dynamic,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 61.dynamic,
                height: 61.dynamic,
                child: Image.asset('images/user.png'),
              ),
              SizedBox(
                width: 13.dynamic,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.aProdouctName ?? 'NA',
                      style: TextStyle(
                          color: Colour.appBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.dynamic),
                    ),
                    SizedBox(
                      height: 4.dynamic,
                    ),
                    Text(
                      'ID - ${item.aServiceID}',
                      style: TextStyle(
                          color: Colour.appDarkGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.dynamic),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.dynamic,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service Name',
                      style: TextStyle(
                          color: Colour.appDarkGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.dynamic),
                    ),
                    SizedBox(
                      height: 4.dynamic,
                    ),
                    Text(
                      item.aServiceName ?? "NA",
                      style: TextStyle(
                          color: Colour.appBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.dynamic),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer Name:',
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
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('images/user.png'),
                            ),
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(37.5.dynamic),
                          ),
                        ),
                        SizedBox(
                          width: 7.dynamic,
                        ),
                        Text(
                          item.aCustomerName ?? 'NA',
                          style: TextStyle(
                              color: Colour.appBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.dynamic),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 21.dynamic,
          ),
          if (isNeedScheduledTime)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 10.dynamic),
                      child: Text(
                        'Scheduled Time:',
                        style: TextStyle(
                          color: Colour.appDarkGrey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.dynamic,
                        ),
                      ),
                    ),
                    Text(
                      item.aPurchaseDate ?? "NA",
                      style: TextStyle(
                        color: Colour.appBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.dynamic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          if (isNeedScheduledTime)
            SizedBox(
              height: 21.dynamic,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
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
                  String query =
                      Uri.encodeComponent(item.aCombinedAddress ?? '');
                  String googleUrl =
                      "https://www.google.com/maps/search/?api=1&query=$query";
                  print(query);
                  if (await canLaunch(googleUrl)) {
                    await launch(googleUrl);
                  }
                },
                child: Container(
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
            item.aCombinedAddress ?? 'NA',
            style: TextStyle(
                color: Colour.appBlack,
                fontWeight: FontWeight.w600,
                fontSize: 14.dynamic),
          ),
          SizedBox(
            height: 15.dynamic,
          ),
          Row(
            children: [
              buttonTitle != null
                  ? ExpanderOrContainer(
                      isContainer: true,
                      child: Container(
                        margin: EdgeInsets.only(right: 18.dynamic),
                        child: Material(
                          // elevation: 5.0,
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colour.appBlue,
                          child: MaterialButton(
                            minWidth: 121.dynamic,
                            height: 44.dynamic,
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            onPressed: () {
                              onJob();
                            },
                            child: Text(
                              buttonTitle ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.dynamic,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              isNeedDetail
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (detailCustomAction != null) {
                            detailCustomAction!();
                          } else {
                            Get.to(
                              () => JobDetailScreen(
                                isNeedStartJob: this.isNeedStartJob,
                                jobID: item.aServiceID!,
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'View Details',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colour.appBlue,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.dynamic,
                                  ),
                                ),
                              ),
                              isNeedStartJob
                                  ? Container()
                                  : Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          //  fetchAndOpenPdf(item.aServiceID!);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PDFViewerScreen(
                                                serviceId: item.aServiceID!,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'View Pdf',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colour.appBlue,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.dynamic,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(height: 15.dynamic),
        ],
      ),
    );
  }
}

class ExpanderOrContainer extends StatelessWidget {
  ExpanderOrContainer({this.child, this.isContainer = true});
  final bool isContainer;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return isContainer ? Container(child: child) : Expanded(child: child!);
  }
}
