import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/controller/attendance_controller.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/reuse/Keys.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import '../../constant.dart';
import 'package:eagle_pixels/reuse/network_image_view.dart';
import 'package:eagle_pixels/reuse/date_manager.dart';

class AttendanceServiceListScreen extends StatelessWidget {
  final AttendanceController attendance = Get.find();
  static String defaultText = 'NA';
  AShowAttendance get detail {
    return attendance.showAttendenceDetail.value;
  }
  // final JobCheckListController checkListController =
  //     Get.put(JobCheckListController());
  // const AttendanceServiceList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            color: Color(0xff757575),
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
                        padding: EdgeInsets.only(
                          left: 20.dynamic,
                          right: 20.dynamic,
                          bottom: 21.dynamic,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 13.dynamic,
                            ),
                            Center(
                              child: Text(
                                attendance.selectedActiveJobDate
                                    .string(AppDateFormat.ddStMMMMYYYY),
                                style: TextStyle(
                                    color: Colour.appBlack,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.dynamic),
                              ),
                            ),
                            SizedBox(
                              height: 13.dynamic,
                            ),
                            Container(
                              padding: EdgeInsets.all(15.dynamic),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5, color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 50.dynamic,
                                        height: 50.dynamic,
                                        alignment: Alignment.center,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          imageUrl: AppController
                                                  .user
                                                  .employeeDetails
                                                  ?.profileImage ??
                                              "",
                                          placeholder: (_, url) => Image.asset(
                                            'images/user.png',
                                          ),
                                          errorWidget: (_, __, ___) =>
                                              Image.asset('images/user.png'),
                                        ),
                                        decoration: BoxDecoration(
                                          // image: DecorationImage(
                                          //   fit: BoxFit.contain,
                                          //
                                          //   image: AssetImage('images/user.png'),
                                          // ),

                                          borderRadius: BorderRadius.circular(
                                              37.5.dynamic),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 13.dynamic,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Name',
                                              style: TextStyle(
                                                  color: Colour.appDarkGrey,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.dynamic),
                                            ),
                                            SizedBox(
                                              height: 4.dynamic,
                                            ),
                                            Text(
                                              '${AppController.user.name}',
                                              style: TextStyle(
                                                  color: Colour.appBlack,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.dynamic),
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
                                      AttendanceTitleDescriptionView(
                                        'Start Day At:',
                                        attendance.isClockedIn
                                            ? attendance.jobStartedTime!.string(
                                                AppDateFormat.attendanceDate)
                                            : defaultText,
                                        color: Colour.appGreen,
                                      ),
                                      AttendanceTitleDescriptionView(
                                          // attendance
                                          //     .arrActiveService
                                          //     .last
                                          //     .aAttendanceEntry
                                          //     ?.last
                                          //     .aEndTime
                                          'End Day At:', //temp clockout time
                                          defaultText,
                                          color: Colour.appRed),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.dynamic,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 21.dynamic,
                            ),
                            Obx(() {
                              if (attendance
                                  .activeJobViewState.value.isLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (attendance
                                  .activeJobViewState.value.isSuccess) {
                                return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: AttendenceDetail(
                                        item:
                                            attendance.arrActiveService[index],
                                      ),
                                    );
                                  },
                                  itemCount: attendance.arrActiveService.length,
                                  // itemCount: attendance.arrActiveService.length,
                                );
                              } else if (attendance
                                  .activeJobViewState.value.isFailed) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Center(
                                    child:
                                        Text(attendance.activeJobErrorMessage),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AttendenceDetail extends StatelessWidget {
  final AActiveService item;
  AttendenceDetail({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.dynamic),
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: 61.dynamic,
                  height: 61.dynamic,
                  child:
                      NetworkImageView(item.aProductImage, kCameraPlaceholder)),
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
                          fontSize: 16.dynamic),
                    ),
                    SizedBox(
                      height: 4.dynamic,
                    ),
                    Text(
                      item.aCctvID ?? 'NA',
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
              AttendanceTitleDescriptionView(
                  'Service Request No:', item.aRequestNo ?? 'NA',),
              AttendanceTitleDescriptionImageView(
                  'Customer Name:', item.aCustomerName, item.aCustomerImage),
            ],
          ),
          SizedBox(
            height: 20.dynamic,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AttendanceTitleDescriptionView('Address:', item.aAddress ?? 'NA'),
              Container(
                width: 120,
              ),
            ],
          ),
          SizedBox(
            height: 15.dynamic,
          ),
          ListView.builder(
            itemBuilder: (con, ind) {
              var entry = item.aAttendanceEntry![ind];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AttendanceTitleDescriptionView(
                        'Start Day At:',
                        entry.aStartTime ?? K.na,
                        color: Colour.appGreen,
                      ),
                      SizedBox(
                        width: 10.dynamic,
                      ),
                      AttendanceTitleDescriptionView(
                          'End Day At:', entry.aEndTime ?? K.na,
                          color: Colour.appRed),
                    ],
                  ),
                  SizedBox(
                    height: 10.dynamic,
                  )
                ],
              );
            },
            itemCount: (item.aAttendanceEntry?.length ?? 0),
            // itemCount: item.aAttendanceEntry?.length ?? 0,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: GestureDetector(
          //         onTap: () {
          //           Get.to(ScheduleJobDetailsScreen(
          //             isNeedServiceReport: true,
          //           ));
          //         },
          //         child: Text(
          //           'View Details',
          //           style: TextStyle(
          //               color: Colour.appBlue,
          //               fontWeight: FontWeight.w400,
          //               fontSize: 16.dynamic),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

extension AttendanceDetailWidgets on AttendanceServiceListScreen {
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
  //
  // Widget get detailsView {
  //   return Text('');
  // }

  Widget get bottomView {
    return Text('');
  }
}

class AttendanceTitleDescriptionView extends StatelessWidget {
  final String title;
  final String? description;
  final Color? color;
  AttendanceTitleDescriptionView(this.title, this.description, {this.color});

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
          Text(
            description!,
            style: TextStyle(
                color: color ?? Colour.appBlack,
                fontWeight: FontWeight.w600,
                fontSize: 14.dynamic),
          ),
        ],
      ),
    );
  }
}

class AttendanceTitleDescriptionImageView extends StatelessWidget {
  final String title;
  final String? description;
  final String? image;
  AttendanceTitleDescriptionImageView(this.title, this.description, this.image);

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
              ClipRRect(
                borderRadius: BorderRadius.circular(12.dynamic),
                child: Container(
                  width: 24.dynamic,
                  height: 24.dynamic,
                  alignment: Alignment.center,
                  child: SvgPicture.network(
                    image!,
                    placeholderBuilder: (BuildContext context) =>
                        Image.asset('images/user.png'),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(37.5.dynamic),
                  ),
                ),
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
