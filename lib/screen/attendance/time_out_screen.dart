import 'package:eagle_pixels/reuse/loader.dart';
import 'package:eagle_pixels/screen/toast/confirmation_screen.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/controller/attendance_controller.dart';
import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/model/profile_model.dart';
import 'package:eagle_pixels/screen/Attendance/time_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import '../../colors.dart';
import '../../constant.dart';
import '../../main.dart';
import 'package:eagle_pixels/api/api_service.dart';

extension TimeOutAction on TimeOutScreen {
  onEndDay() async {
    Get.dialog(
      ConfirmationScreen(),
      barrierDismissible: false,
    ).then((value) async {
      if (value == true) {
        print('yes clicked');
        try {
          showLoading();
          // AppController().verifyUser().then((result) async {
          var model = await attendance.onClockOut();
          if (model?.status?.isSuccess ?? false) {
            navigator!.popUntil((route) => route.settings.name == NavPage.root);
          } else {
            Toast.show(
              model?.message ?? kErrorMsg,
              backgroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 16.0, color: Colors.black),
            );
          }
          // }).catchError((error) {
          //   // Handle errors during verification
          //   print('Error during verification: $error');
          // });
        } finally {
          hideLoading(value: 0);
        }
      } else {
        print('no clicked');
      }
    });
  }

  Future getImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      print('image picked');
      if (pickedFile != null) {
        print(pickedFile.path);
        // var res = await uploadImage(_image.path,
        //     'https://pixel.solstium.net/api/v1/employee/upload_sign');
        // if (res?.isSuccess ?? false) {
        //   var model = await attendance.onClockIn();
        //   if (model?.status?.isSuccess ?? false) {
        //     var resp = MAttendanceStatusResponse();
        //     resp.startedDate = DateTime.now();
        //     attendance.attendanceStatus.value = resp;
        //     Get.toNamed(NavPage.clockOut);
        //   } else {

        //   }
        // } else {

        // }
      } else {
        print('No image selected.');
      }
    } catch (error) {
      print('Error $error');
    }
  }
}

class TimeOutScreen extends StatelessWidget {
  final picker = ImagePicker();
  late PickedFile _image;
  final TimerController timer = Get.find();
  final AttendanceController attendance = Get.find();
  MProfile get user {
    return AppController.user;
  }

  String get difference {
    // print(timer.currentDate.value);
    // print(attendance.jobStartedTime);
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
      body: Stack(
        children: [
          Column(
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
                          attendance.isClockedIn
                              ? DateFormat('dd MMMM yyyy')
                                  .format(attendance.jobStartedTime!)

                              // Jiffy(attendance.jobStartedTime)
                              //     .format('do MMMM yyyy')
                              : '00:00:00',
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
                              description:
                                  user.employeeDetails?.department ?? "NA",
                            ),
                            TimeInOutDetailItem(
                              title: 'Employee ID::',
                              description: user.employeeCode ?? "NA",
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            TimeInOutDetailItem(
                              title: 'Joining Date:',
                              description: (user
                                          .employeeDetails?.aRegisteraionDate !=
                                      null)
                                  ? DateFormat('dd.MM.yyyy').format(
                                      user.employeeDetails!.aRegisteraionDate!)
                                  : 'NA',
                            ),
                            TimeInOutDetailItem(
                                title: 'Today:',
                                description: DateFormat('dd MMMM yyyy')
                                    .format(timer.currentDate.value)

                                // Jiffy(timer.currentDate.value)
                                //     .format('do MMMM yyyy'),
                                ),
                          ],
                        ),
                        Row(
                          children: [
                            TimeInOutDetailItem(
                                title: 'Time in:',
                                description: attendance.isClockedIn
                                    ? DateFormat('hh:mm:ss a')
                                        .format(attendance.jobStartedTime!)

                                    // Jiffy(attendance.jobStartedTime)
                                    //     .format('hh:mm:ss a')
                                    : '00:00:00'),
                            Obx(
                              () => TimeInOutDetailItem(
                                title: 'Time Count:',
                                description: this.difference,
                              ),
                            ),
                          ],
                        ),
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
                            onPressed: this.onEndDay,
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
          AppController.to.defaultLoaderView(),
        ],
      ),
    );
  }
}
