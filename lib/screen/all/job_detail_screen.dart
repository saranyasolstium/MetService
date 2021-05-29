import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/controller/job_detail_controller.dart';
import 'package:eagle_pixels/controller/schedule_list_controller.dart';
import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:eagle_pixels/main.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/reuse/Keys.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:jiffy/jiffy.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:toast/toast.dart';

import '../../colors.dart';

// ignore: must_be_immutable
extension JobDetailAction on JobDetailScreen {
  onStartJob() async {
    showLoading();
    var res = await schedule.onStartJob(service_id: detail.aServiceId ?? '0');
    hideLoading();
    String status = res[K.status] ?? '';
    String error = res['error'] ?? '';
    if (isSuccess(K.success) || error == K.already_checkIn) {
      Get.toNamed(NavPage.jobCheckListScreen);
    } else {
      Toast.show(error, Get.context);
    }

    print('Reached onstart job');
    // showLoading();
    // await AppController.to.localAuth();
    // hideLoading();
    // Get.toNamed(NavPage.jobCheckListScreen);
  }
}

class JobDetailScreen extends StatelessWidget {
  final controller = Get.put(JobDetailController());
  final ScheduleListController schedule = Get.find();

  final bool isNeedContainer;
  JobDetailScreen({this.isNeedContainer = true});

  late PDFDocument document;
  AJobDetail get detail {
    return controller.detail.value;
  }

  @override
  Widget build(BuildContext context) {
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
                                  SizedBox(height: 13.dynamic),
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
                                  this.cameraInfoView,
                                  SizedBox(height: 20.dynamic),
                                  Text(
                                    'Ticket Information:',
                                    style: TextStyle(
                                        color: Colour.appBlue,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.dynamic),
                                  ),
                                  SizedBox(height: 10.dynamic),
                                  this.tickInformationView,
                                  SizedBox(height: 30.dynamic),
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
                                        padding: EdgeInsets.only(
                                            top: 20.dynamic,
                                            bottom: 10.dynamic),
                                        child: Text(
                                          'Site MAP:',
                                          style: TextStyle(
                                              color: Colour.appDarkGrey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12.dynamic),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(8.dynamic),
                                    ),
                                    height: 112.dynamic,
                                    child: IgnorePointer(
                                      child: FlutterMap(
                                        options: MapOptions(
                                          center: LatLng(12.22532035463426,
                                              79.68630931341535),
                                          zoom: 11.0,
                                          boundsOptions: FitBoundsOptions(
                                              padding: EdgeInsets.all(8.0)),
                                        ),
                                        layers: [
                                          TileLayerOptions(
                                              urlTemplate:
                                                  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                              subdomains: ['a', 'b', 'c']),
                                          MarkerLayerOptions(
                                            markers: [
                                              Marker(
                                                width: 80.0,
                                                height: 80.0,
                                                point: LatLng(
                                                    12.226456173312162,
                                                    79.65054512543048),
                                                builder: (ctx) => Container(
                                                  child: Icon(
                                                    Icons.location_on,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
                                  // isNeedServiceReport
                                  //     ? Container(
                                  //         child: Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: [
                                  //             SizedBox(
                                  //               height: 10.dynamic,
                                  //             ),
                                  //             Divider(
                                  //               color: Colors.grey,
                                  //             ),
                                  //             SizedBox(
                                  //               height: 10.dynamic,
                                  //             ),
                                  //             Text(
                                  //               'Service Report',
                                  //               style: TextStyle(
                                  //                   color: Colour.appBlue,
                                  //                   fontWeight: FontWeight.w400,
                                  //                   fontSize: 16.dynamic),
                                  //             ),
                                  //             this.serviceReportView
                                  //           ],
                                  //         ),
                                  //       )
                                  //     : Container(), ///
                                  //temp
                                ],
                              ),
                            ),
                          ),
                        ),
                        // this.bottomView,
                        isNeedContainer ? this.bottomView : Container(), //temp
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
  // Widget androidDropdown() {
  //   List<DropdownMenuItem<String>> dropdownItems = [];
  //   var siteList = detailController.arrSites;
  //   siteList.forEach((site) {
  //     dropdownItems.add(
  //       DropdownMenuItem(
  //         child: Text(site.displayText),
  //         value: site.displayText,
  //       ),
  //     );
  //   });
  //
  //   // for (String site in siteList.value) {
  //   //   var newItem = DropdownMenuItem(
  //   //     child: Text(site.),
  //   //     value: site,
  //   //   );
  //   //   dropdownItems.add(newItem);
  //   // }
  //
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 19.dynamic),
  //     padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       color: Colour.appLightGrey,
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(5.dynamic),
  //       ),
  //     ),
  //     child: DropdownButton<String>(
  //       value: detailController.selectedSite.value?.displayText ?? '',
  //       items: dropdownItems,
  //       underline: Container(),
  //       icon: Expanded(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Icon(
  //               Icons.keyboard_arrow_down,
  //               size: 30.dynamic,
  //               color: Colour.appDarkGrey,
  //             ),
  //           ],
  //         ),
  //       ),
  //       onChanged: (value) {
  //         detailController.selectedSite.value = detailController.arrSites
  //             .where((element) => element.displayText == value)
  //             .first;
  //       },
  //     ),
  //   );
  // }

  Widget get cameraInfoView {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          'images/camera.png',
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
                safeString(detail.aCameraName),
                style: TextStyle(
                    color: Colour.appBlack,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.dynamic),
              ),
              SizedBox(
                height: 4.dynamic,
              ),
              Text(
                safeString(detail.aCameraID),
                style: TextStyle(
                    color: Colour.appDarkGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.dynamic),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get tickInformationView {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView('Ticket ID:', detail.aTicketID),
            JobDetailTitleDescriptionView('Priority:', detail.aPriority),
          ],
        ),
        SizedBox(height: 15.dynamic),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView('Status:', detail.aStatus),
            JobDetailTitleDescriptionView('Source:', detail.aSource),
          ],
        ),
        SizedBox(height: 15.dynamic),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          JobDetailTitleDescriptionView('Subject:', detail.aSubject),
        ]),
        SizedBox(height: 15.dynamic),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          JobDetailTitleDescriptionView('Description:', detail.aDescription),
        ]),
      ],
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
                'Customer:', detail.aCustomerName, 'image'),
            JobDetailTitleDescriptionView('Item:', detail.aItem),
          ],
        ),
        SizedBox(height: 15.dynamic),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Serial Number:', detail.aSerialNumber),
            JobDetailTitleDescriptionView('Site:', detail.aSite),
          ],
        ),
        SizedBox(height: 15.dynamic),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView('Subsite:', detail.aSubSite),
            JobDetailTitleDescriptionView('Sale Order', detail.aSaleOrder),
          ],
        )
      ],
    );
  }

  Widget get serviceInformationView {
    return Column(
      children: [
        SizedBox(height: 10.dynamic),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionImageView(
                'Customer:', detail.aCustomerName, detail.aCustomerImage),
            JobDetailTitleDescriptionView('Item:', detail.aItem),
          ],
        ),
        SizedBox(height: 15.dynamic),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Serial Number:', detail.aSerialNumber),
            JobDetailTitleDescriptionView('Site:', detail.aSite),
          ],
        ),
        SizedBox(height: 15.dynamic),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView('Subsite:', detail.aSubSite),
            JobDetailTitleDescriptionView('Sale Order', detail.aSaleOrder),
          ],
        )
      ],
    );
  }

  // Widget get detailsView {
  //   return Column(
  //     children: [
  //       SizedBox(
  //         height: 20.dynamic,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           JobDetailTitleDescriptionView(
  //               'Purchase Date:', detail.aPurchaseDate),
  //           JobDetailTitleDescriptionView(
  //               'Purchase Order Number:', detail.aPurchaseOrderNumber),
  //         ],
  //       ),
  //       SizedBox(
  //         height: 15.dynamic,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           JobDetailTitleDescriptionView(
  //               'Scheduled Date:', detail.aScheduleDate),
  //           JobDetailTitleDescriptionImageView('Customer Name:',
  //               detail.aCustomerName, detail.aCameraImage ?? '')
  //         ],
  //       ),
  //       SizedBox(
  //         height: 15.dynamic,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           JobDetailTitleDescriptionView(
  //               'Scheduled Time:', detail.aScheduleTime),
  //           JobDetailTitleDescriptionImageView(
  //               'Scheduled By:', detail.aScheduledBy, detail.aScheduledBy)
  //         ],
  //       ),
  //       SizedBox(
  //         height: 15.dynamic,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           JobDetailTitleDescriptionView(
  //               'Warranty Status', detail.aWarrantyStatus),
  //           JobDetailTitleDescriptionView(
  //               'Warranty Ending On', detail.aWarrantyEndingOn),
  //         ],
  //       ),
  //       SizedBox(
  //         height: 15.dynamic,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Expanded(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'Instructions from Customer',
  //                   style: TextStyle(
  //                       color: Colour.appDarkGrey,
  //                       fontWeight: FontWeight.w400,
  //                       fontSize: 12.dynamic),
  //                 ),
  //                 SizedBox(
  //                   height: 4.dynamic,
  //                 ),
  //                 Text(
  //                   detail.aCustomerInstruction ?? 'NA',
  //                   style: TextStyle(
  //                       color: Colour.appRed,
  //                       fontWeight: FontWeight.w400,
  //                       fontSize: 14.dynamic),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

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
                'Type of Service:', detail.aTypeOfService),
            JobDetailTitleDescriptionView(
                'Service Amount', detail.aServiceAmount),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView('Service:', detail.aService),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Floor Plan',
                    style: TextStyle(
                        color: Colour.appDarkGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.dynamic),
                  ),
                  SizedBox(
                    height: 4.dynamic,
                  ),
                  GestureDetector(
                    onTap: () async {
                      document = await PDFDocument.fromURL(
                        "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
                        /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
                      );
                      Get.bottomSheet(
                        Center(
                          child: Container(
                            child: PDFViewer(
                              document: document,
                            ),
                          ),
                        ),
                        isScrollControlled: true,
                        ignoreSafeArea: false,
                      );
                    },
                    child: Text(
                      detail.aFloorPlan ?? 'NA',
                      style: TextStyle(
                          color: Colour.appBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.dynamic),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget get warrantyInfo {
  //   return Column(
  //     children: [
  //       SizedBox(
  //         height: 20.dynamic,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           JobDetailTitleDescriptionView(
  //               'Customer Warranty Information', detail.aPurchaseDate),
  //         ],
  //       ),
  //       SizedBox(
  //         height: 20.dynamic,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           JobDetailTitleDescriptionView(
  //               'Vendor Warranty Information', detail.aPurchaseDate),
  //         ],
  //       ),
  //     ],
  //   );
  // }

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
                // var time = DateFormat('hh:mm a').format(DateTime.now());
                Jiffy(TimerController.to.currentDate.value)
                    .format('hh:mm a  |  do MMMM yyyy'),
                // DateFormat('hh:mm a | MMst MMMM yyyy').format(DateTime.now()),
                // '09:10 AM  |  21st September 2021',
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
            // androidDropdown(), //temp
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
                  'Start Job',
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
            safeString(description),
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

class JobDetailTitleDescriptionImageView extends StatelessWidget {
  final String title;
  final String? description;
  final String? image;
  JobDetailTitleDescriptionImageView(this.title, this.description, this.image);

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
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: image ?? "",
                  placeholder: (_, url) => Image.asset(
                    'images/user.png',
                  ),
                ),
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   fit: BoxFit.contain,
                  //   image:
                  //   AssetImage('images/user.png'),
                  // ),
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
                safeString(description),
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