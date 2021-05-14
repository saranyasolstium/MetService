import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/controller/attendance_controller.dart';
import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/main.dart';
import 'package:eagle_pixels/model/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../colors.dart';
import '../../constant.dart';
import 'package:eagle_pixels/api/api_service.dart';

extension TimeInAction on TimeInScreen {
  startDay() async {
    var model = await attendance.onClockIn();
    if (model?.status?.isSuccess ?? false) {
      Get.toNamed(NavPage.clockOut);
    } else {
      //TODO: show error toast
    }
  }
}

class TimeInScreen extends StatelessWidget {
  final TimerController timer = Get.find();
  final AttendanceController attendance = Get.find();
  MProfile get user {
    return AppController.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleText('Mark Attendance'),
        backgroundColor: CupertinoColors.white,
        elevation: 0,
        leading: RawMaterialButton(
          onPressed: Get.back,
          child: Icon(
            Icons.arrow_back,
            color: Colour.appBlue,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 17.dynamic),
          color: HexColor.fromHex("F7F7F7"),
          child: Column(
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
                // child: Image.asset(
                //   'images/user.png',
                // ),
                child: CachedNetworkImage(
                  width: 64.dynamic,
                  height: 64.dynamic,
                  imageUrl: user.employeeDetails?.profileImage ?? "",
                  placeholder: (_, url) => Image.asset(
                    'images/user.png',
                  ),
                ),
              ),
              Row(
                children: [
                  TimeInOutDetailItem(
                    title: 'Name:',
                    description: user.name,
                  ),
                  TimeInOutDetailItem(
                    title: 'Designation::',
                    description: user.employeeDetails?.designation,
                  ),
                ],
              ),
              Row(
                children: [
                  TimeInOutDetailItem(
                    title: 'Department::',
                    description: user.employeeDetails?.department,
                  ),
                  TimeInOutDetailItem(
                    title: 'Employee ID::',
                    description: user.employeeCode,
                  ),
                ],
              ),
              Row(
                children: [
                  TimeInOutDetailItem(
                    title: 'Joining Date::',
                    description: DateFormat('dd:MM:yyyy')
                        .format(user.employeeDetails!.registerationDate!),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 85.dynamic, bottom: 23.dynamic),
                child: Align(
                  child: Text(
                    'Time In',
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
                          bottomText:
                              DateFormat('hh').format(timer.currentDate.value),
                        )),
                    TimeComponentItem(
                      topText: "",
                      bottomText: ":",
                    ),
                    Obx(() => TimeComponentItem(
                          topText: "MM",
                          bottomText:
                              DateFormat('mm').format(timer.currentDate.value),
                        )),
                    TimeComponentItem(
                      topText: "",
                      bottomText: ":",
                    ),
                    Obx(() => Container(
                          width: 45.dynamic,
                          child: TimeComponentItem(
                            topText: "SS",
                            bottomText: DateFormat('ss')
                                .format(timer.currentDate.value),
                          ),
                        )),
                    TimeComponentItem(
                      topText: '',
                      bottomText:
                          DateFormat('a').format(timer.currentDate.value),
                      bottomTextColor: '9A9A9A',
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: HexColor.fromHex("14CE1A"),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.dynamic),
                  ),
                ),
                margin: EdgeInsets.symmetric(vertical: 32.dynamic),
                width: double.infinity,
                child: TextButton(
                  onPressed: this.startDay,
                  child: Text(
                    'Start the day',
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
    );
  }
}

class TimeComponentItem extends StatelessWidget {
  final String topText;
  final String topTextColor;
  final String bottomText;
  final String bottomTextColor;

  TimeComponentItem(
      {this.topText = '',
      this.topTextColor = "9A9A9A",
      this.bottomText = '',
      this.bottomTextColor = "14CE1A"});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            topText,
            style: TextStyle(
              fontSize: 20.dynamic,
              fontWeight: FontWeight.normal,
              color: HexColor.fromHex(topTextColor),
            ),
          ),
          Text(
            bottomText,
            style: TextStyle(
              fontSize: 29.dynamic,
              fontWeight: FontWeight.w700,
              color: HexColor.fromHex(bottomTextColor),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeInOutDetailItem extends StatelessWidget {
  final String title;
  final String? description;

  TimeInOutDetailItem({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.dynamic),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12.dynamic,
                fontWeight: FontWeight.normal,
                color: HexColor.fromHex("9A9A9A"),
              ),
            ),
            Text(
              safeString(description),
              style: TextStyle(
                fontSize: 14.dynamic,
                fontWeight: FontWeight.w600,
                color: HexColor.fromHex("333333"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
