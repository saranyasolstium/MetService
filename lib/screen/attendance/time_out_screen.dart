import 'package:eagle_pixels/controller/attendance_controller.dart';
import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/screen/Attendance/time_in_screen.dart';
import 'package:eagle_pixels/screen/toast/confirmation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import '../../colors.dart';
import '../../constant.dart';
import '../../main.dart';
import 'package:eagle_pixels/api/api_service.dart';

extension TimeOutAction on TimeOutScreen {
  onEndDay() async {
    var model = await attendance.onClockOut();
    if (model?.status?.isSuccess ?? false) {
      Get.toNamed(NavPage.clockOut);
    } else {
      //TODO: show error toast
    }
  }
}

class TimeOutScreen extends StatelessWidget {
  final TimerController timer = Get.find();
  final AttendanceController attendance = Get.find();

  String get difference {
    var current = timer.currentDate.value;
    var start = attendance.jobStartedTime;
    if (start == null) {
      return '00 : 00 : 00 Hrs';
    }
    var hour = current.difference(start).inHours;
    num min = current.difference(start).inMinutes.remainder(60);
    num second = current.difference(start).inSeconds.remainder(60);
    var txt = "Hrs";
    if (hour == 0) {
      if (min == 0) {
        txt = 'Seconds';
      } else {
        txt = 'Mins';
      }
    }
    return '${hour > 9 ? hour : '0$hour'}:${min > 9 ? min : '0$min'}:${second > 9 ? second : '0$second'} $txt';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleText('Close Attendance'),
        backgroundColor: CupertinoColors.white,
        elevation: 0,
        leading: RawMaterialButton(
          onPressed: () {
            // Get.offNamed(NavPage.calendar);
            navigator!
                .popUntil((route) => route.settings.name == NavPage.calendar);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colour.appBlue,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
                vertical: 12.dynamic, horizontal: 17.dynamic),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Jiffy(attendance.jobStartedTime).format('do MMMM yyyy'),
                      style: TextStyle(
                        fontSize: 12.dynamic,
                        fontWeight: FontWeight.normal,
                        color: Colour.appDarkGrey,
                      ),
                    ),
                    SizedBox(height: 5.dynamic),
                    Text(
                      attendance.isClockedIn
                          ? DateFormat('hh:mm:ss a')
                              .format(attendance.jobStartedTime!)
                          : '00:00:00',
                      style: TextStyle(
                        fontSize: 16.dynamic,
                        fontWeight: FontWeight.w600,
                        color: Colour.appBlack,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Timer Count',
                      style: TextStyle(
                        fontSize: 12.dynamic,
                        fontWeight: FontWeight.normal,
                        color: Colour.appDarkGrey,
                      ),
                    ),
                    SizedBox(height: 5.dynamic),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('images/clock.png'),
                        SizedBox(width: 10),
                        Obx(
                          () => Text(
                            this.difference,
                            style: TextStyle(
                              fontSize: 16.dynamic,
                              fontWeight: FontWeight.w600,
                              color: Colour.appBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                // margin: EdgeInsets.only(top: 100),
                padding: EdgeInsets.symmetric(horizontal: 17.dynamic),
                color: HexColor.fromHex("F7F7F7"),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 22.dynamic),
                      child: Align(
                        child: Text(
                          'Employee Information',
                          style: TextStyle(
                              color: Colour.appBlue,
                              fontSize: 16.dynamic,
                              fontWeight: FontWeight.normal),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        'images/user.png',
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     TimeInOutDetailItem(),
                    //     TimeInOutDetailItem(),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     TimeInOutDetailItem(),
                    //     TimeInOutDetailItem(),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     TimeInOutDetailItem(),
                    //     TimeInOutDetailItem(),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     TimeInOutDetailItem(),
                    //     TimeInOutDetailItem(),
                    //   ],
                    // ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 22.dynamic),
                      child: Align(
                        child: Text(
                          'Time Out',
                          style: TextStyle(
                              color: Colour.appBlue,
                              fontSize: 16.dynamic,
                              fontWeight: FontWeight.normal),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => TimeComponentItem(
                                topText: "HH",
                                bottomText: DateFormat('hh')
                                    .format(timer.currentDate.value),
                                bottomTextColor: 'DB1A1A',
                              )),
                          TimeComponentItem(
                            topText: "",
                            bottomText: ":",
                            bottomTextColor: 'DB1A1A',
                          ),
                          Obx(() => TimeComponentItem(
                                topText: "MM",
                                bottomText: DateFormat('mm')
                                    .format(timer.currentDate.value),
                                bottomTextColor: 'DB1A1A',
                              )),
                          TimeComponentItem(
                            topText: "",
                            bottomText: ":",
                            bottomTextColor: 'DB1A1A',
                          ),
                          Obx(() => Container(
                                width: 45.dynamic,
                                child: TimeComponentItem(
                                  topText: "SS",
                                  bottomText: DateFormat('ss')
                                      .format(timer.currentDate.value),
                                  bottomTextColor: 'DB1A1A',
                                ),
                              )),
                          Obx(() => TimeComponentItem(
                                topText: '',
                                bottomText: DateFormat('a')
                                    .format(timer.currentDate.value),
                                bottomTextColor: '9A9A9A',
                              ))
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colour.appRed,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.dynamic),
                        ),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 32.dynamic),
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Get.dialog(
                            ConfirmationScreen(),
                            barrierDismissible: false,
                          ).then((value) {
                            if (value == true) {
                              print('yes clicked');
                              Get.offAllNamed('/');
                            } else {
                              print('no clicked');
                            }
                          });
                        },
                        child: Text(
                          'End the day',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.dynamic,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
