import 'dart:convert';

import 'package:eagle_pixels/api/headers.dart';
import 'package:eagle_pixels/common/logger.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/controller/attendance_controller.dart';
import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/main.dart';
import 'package:eagle_pixels/model/attendece_status_model.dart';
import 'package:eagle_pixels/model/profile_model.dart';
import 'package:eagle_pixels/reuse/date_manager.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:eagle_pixels/screen/toast/confirmation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:month_picker_dialog/month_picker_dialog.dart';

import 'package:http/http.dart' as http;
import 'package:eagle_pixels/api/api_service.dart';
import '../../colors.dart';
import 'package:toast/toast.dart';

extension CalendarAction on CalendarScreen {
  // startOrEndDay() async {
  //   final status = attendance.attendanceStatus.value;
  //   print(attendance.isClockedIn);
  //   if (status != null) {
  //     if (status.isServiceStarted && !status.isAttendanceStarted) {
  //       Toast.show(
  //         'You already in service attendance',
  //         backgroundColor: Colors.white,
  //         textStyle: TextStyle(
  //             fontSize: 16.dynamic,
  //             color: Colors.black), // Provide an appropriate TextStyle
  //       );
  //       //print('You already in service attendance');
  //       return;
  //     }
  //   }
  //   if (attendance.isClockedIn) {
  //     Get.toNamed(NavPage.clockOut);
  //   } else {
  //     startDay();
  //     if (!attendance.isAllowForClockIn) {
  //       //temp inverse condition
  //     } else {
  //       Toast.show(
  //         'Please clock out the service attendance',
  //         backgroundColor: Colors.white,
  //         textStyle: TextStyle(fontSize: 16.0, color: Colors.black),
  //       );
  //     }
  //   }
  //   // var response = await attendance.onClockIn();
  //   // if (response!.isValid) {}
  // }

  startOrEndDay() async {
    final status = attendance.attendanceStatus.value;
    print(status?.isAttendanceStarted);
    print(status?.isServiceStarted);

    if (status != null) {
      if (status.isServiceStarted && !status.isAttendanceStarted) {
        Toast.show(
          'You already in service attendance', backgroundColor: Colors.white,
          textStyle: TextStyle(
              fontSize: 16.dynamic,
              color: Colors.black), 
        );
        return;
      }
    }
    if (attendance.isClockedIn) {
      onEndDay();
      // Get.toNamed(NavPage.clockOut);
    } else {
      startDay();
      // if (!attendance.isAllowForClockIn) {
      //   //temp inverse condition
      //
      // } else {
      //   Toast.show('Please clock out the service attendance', Get.context);
      // }
    }
    // var response = await attendance.onClockIn();
    // if (response!.isValid) {}
  }

  startDay() async {
    //comment by saranya
    if (AppController.to.isAttendanceEngineer) {
      if (attendance.selectedSite.value == null) {
        Toast.show(
          'invalid selected site',
          backgroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 16.0, color: Colors.black),
        );
        return;
      }
    }
    showLoading();
    try {
      print(MAttendanceStatusResponse);
      // AppController().verifyUser().then((result) async {
      var model = await attendance.onClockIn();
      if (model?.status?.isSuccess ?? false) {
        var resp = MAttendanceStatusResponse();
        resp.startedDate = DateTime.now();
        attendance.attendanceStatus.value = resp;
        final status = attendance.attendanceStatus.value;
        if (status != null) {
          status.isAttendanceStarted = !status.isAttendanceStarted;
          attendance.update();
        } else {
          attendance.attendanceStatus.value = MAttendanceStatusResponse();
          attendance.attendanceStatus.value!.isAttendanceStarted = true;
          attendance.update();
        }
        Get.toNamed(NavPage.clockOut);
      } else {
        Toast.show(
          model?.message ?? 'Problem in clock in. please try again.',
          backgroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 16.0, color: Colors.black),
        );
      }
      // }).catchError((error) {
      //   // Handle errors during verification
      //   print('Error during verification: $error');
      // });
    } catch (e) {
      Toast.show(
        '$e',
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16.0, color: Colors.black),
      );
    } finally {
      hideLoading(value: 0);
    }
  }

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

  showAttendance(String date) {
    print('showAttendance');
    Get.toNamed(NavPage.attendanceServiceList);
    attendance.fetchService(date);
  }

  selectMonth() {
    final currentYear = int.parse(DateFormat.y().format(DateTime.now()));
    showMonthPicker(
      context: Get.context!,
      firstDate: DateTime(currentYear - 30),
      lastDate: DateTime(currentYear + 1),
      initialDate: attendance.selectedDate,
    ).then((value) {
      if (value != null) {
        var month = DateFormat.MMMM().format(value);
        var selectedMonthInNumber = DateFormat('MM').format(value);
        attendance.selectedMonthInNumber = selectedMonthInNumber;
        attendance.selectedMonth.value = month.toString();
        attendance.fetchAttendance(isShowLoading: true);
      }
    });
  }

  selectYear() {
    final currentYear = int.parse(DateFormat.y().format(DateTime.now()));
    showDatePicker(
      context: Get.context!,
      initialDate: attendance.selectedDate,
      firstDate: DateTime(currentYear - 1),
      lastDate: DateTime(currentYear + 1),
      initialDatePickerMode: DatePickerMode.year,
      initialEntryMode: DatePickerEntryMode.calendar,
    ).then((value) {
      if (value != null) {
        print(value);
        var year = DateFormat.y().format(value);
        attendance.selectedYear.value = year.toString();
        attendance.fetchAttendance(isShowLoading: true);
      }
    });
  }
}

// ignore: must_be_immutable
class CalendarScreen extends StatelessWidget {
  final AttendanceController attendance = Get.find();

  MProfile get user {
    return AppController.user;
  }

  late PickedFile _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    if (!attendance.isAttendanceHereForSelected) {
      attendance.fetchAttendance(isShowLoading: true);
    }

    return Scaffold(
      appBar: this.appBar,
      backgroundColor: HexColor.fromHex("F7F7F7"),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.dynamic),
                this.yearMonth,
                SizedBox(
                  height: 35.dynamic,
                ),
                Container(
                  child: this.calendarSurround,
                ),
                SizedBox(
                  height: 86.dynamic,
                ),
                (AppController.to.isAttendanceEngineer &&
                        !attendance.isClockedIn)
                    ? bottomView1
                    : bottomView2,
              ],
            ),
          ),
          AppController.to.defaultLoaderView(),
        ],
      ),
    );
  }
}

extension CalendarWidgets on CalendarScreen {
  AppBar get appBar {
    return AppBar(
          toolbarHeight: 50.dynamic,
          elevation: 0,
          backgroundColor: Color(0xFFFFFFFF),
          leading: RawMaterialButton(
            onPressed: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              color: Colour.appBlue,
              size: 20.dynamic,
            ),
          ),
          title: titleText('Attendance'),
        );
    
    
  }

  Widget get yearMonth {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: this.selectYear,
              child: Padding(
                padding: EdgeInsets.only(left: 17, right: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Year',
                      style: TextStyle(
                          color: Colour.appDarkGrey,
                          fontSize: 14.dynamic,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 11.dynamic,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Color(0xFFFFFFFF),
                      ),
                      padding:
                          EdgeInsets.only(top: 12.0, left: 13.0, bottom: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Obx(() {
                                    return Text(
                                      '   ${attendance.selectedYear}',
                                      style: TextStyle(
                                          color: Colour.appText,
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w400),
                                    );
                                  }),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colour.appBlack,
                                  size: 30.dynamic,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: this.selectMonth,
              child: Padding(
                padding: EdgeInsets.only(left: 14, right: 17.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Month',
                      style: TextStyle(
                          color: Colour.appDarkGrey,
                          fontSize: 14.dynamic,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 11.dynamic,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Color(0xFFFFFFFF),
                      ),
                      padding:
                          EdgeInsets.only(top: 12.0, left: 13.0, bottom: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Obx(() {
                                    return Text(
                                      '   ${attendance.selectedMonth}',
                                      style: TextStyle(
                                          color: Colour.appText,
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w400),
                                    );
                                  }),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colour.appBlack,
                                  size: 30.dynamic,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get calendarSurround {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colour.appBlue,
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 12.dynamic, left: 16, bottom: 12.dynamic),
                child: Container(child: Obx(() {
                  return Text(
                    '${attendance.selectedMonth}, ${attendance.selectedYear}',
                    style: TextStyle(
                      fontSize: 14.dynamic,
                      fontWeight: FontWeight.w600,
                      color: HexColor.fromHex('#0494FC'),
                    ),
                  );
                })),
              ),
              Divider(
                color: Colour.appBlue,
                thickness: 1.0,
              ),
              GetBuilder<AttendanceController>(builder: (_) {
                return this.calendar;
              }),
            ],
          ),
        ), //
      ],
    );
  }

  Widget get calendar {
    return CalendarCarousel<Event>(
      targetDateTime:
          DateTime.now().subtract(Duration(days: DateTime.now().day - 1)),

      todayBorderColor: Colors.transparent,
      customDayBuilder: (isSelectable,
          index,
          isSelectedDay,
          isToday,
          isPrevMonthDay,
          styleForBuilder,
          isNextMonthDay,
          isThisMonthDay,
          now) {
        return CalendarItem(
          isSelectable,
          index,
          isSelectedDay,
          isToday,
          isPrevMonthDay,
          styleForBuilder,
          isNextMonthDay,
          isThisMonthDay,
          now,
          attendance.presentedDayInSelectedMonth,
          // attendance.absentDays(),
          // attendance.halfPresentedDays(),
          [],
          [],
        );
      },
      onDayPressed: (date, events) {
        print("saranya $date");
        attendance.selectedActiveJobDate = date;
        this.showAttendance(DateFormat(AppDateFormat.yyyy_MM_dd).format(date));
      },

      // weekdayTextStyle: TextStyle(
      //   color: Colors.green,
      // ),
      daysHaveCircularBorder: false,
      showOnlyCurrentMonthDate: true,
      // w      thisMonthDayBorderColor: Colors.transparent,
      height: 320.dynamic,
      // selectedDateTime: _currentDate2,
      // targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      todayButtonColor: Colors.white,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      selectedDayBorderColor: Colors.white,
      customWeekDayBuilder: (index, day) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            day,
            style: TextStyle(
              fontSize: 14.dynamic,
              fontWeight: FontWeight.w500,
              color: (index == 0 || index == 6) ? Colors.red : Colors.grey,
            ),
          ),
        );
      },

      scrollDirection: Axis.horizontal,
      isScrollable: false,
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),

      onDayLongPressed: (DateTime date) {},
    );
  }

  Widget androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    var siteList = attendance.arrSite;
    siteList.forEach((site) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(site.displayText),
          value: site.displayText,
        ),
      );
    });
    return Container(
      margin: EdgeInsets.only(bottom: 19.dynamic),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colour.appLightGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(5.dynamic),
        ),
      ),
      child: DropdownButton<String>(
        value: attendance.selectedSite.value?.displayText ?? '',
        items: dropdownItems,
        underline: Container(),
        icon: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.keyboard_arrow_down,
                size: 30.dynamic,
                color: Colour.appDarkGrey,
              ),
            ],
          ),
        ),
        onChanged: (value) {
          attendance.selectedSite.value = attendance.arrSite
              .where((element) => element.displayText == value)
              .first;
        },
      ),
    );
  }

  Widget get bottomView1 {
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
            androidDropdown(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colour.appBlue,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.dynamic),
                ),
              ),
              child: TextButton(
                onPressed: this.startOrEndDay,
                child: Text(
                  'Start the day',
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

  Widget get bottomView2 {
    return Column(
      children: [
        Obx(
          () => Text(
            DateFormat('hh:mm a  |  dd MMMM yyyy')
                .format(TimerController.to.currentDate.value),
            style: TextStyle(
              fontSize: 14.dynamic,
              fontWeight: FontWeight.w600,
              color: HexColor.fromHex("333333"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colour.appBlue,
              borderRadius: BorderRadius.all(
                Radius.circular(5.dynamic),
              ),
            ),
// margin: EdgeInsets.symmetric(vertical: 32.dynamic),
            width: double.infinity,
            child: RawMaterialButton(
              onPressed: () {},
              child: TextButton(
                onPressed: this.startOrEndDay,
                child: GetBuilder<AttendanceController>(
                  builder: (_) {
                    return Text(
                      attendance.isClockedIn ? 'End the day' : 'Start the day',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.dynamic,
                          fontWeight: FontWeight.w300),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        !AppController.to.isAttendanceEngineer
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.5, color: Colour.appGreen),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.dynamic),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    attendance.selectedActiveJobDate = DateTime.now();
                    this.showAttendance(DateFormat(AppDateFormat.yyyy_MM_dd)
                        .format(DateTime.now()));
                  },
                  child: Text(
                    'Show Attendance',
                    style: TextStyle(
                        color: Colour.appGreen,
                        fontSize: 16.dynamic,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              )
            : Container(),
        SizedBox(
          height: 14.dynamic,
        ),
      ],
    );
  }
}

class CalendarItem extends StatelessWidget {
  final bool isSelectable;
  final int index;
  final bool isSelectedDay;
  final bool isToday;
  final bool isPrevMonthDay;
  final TextStyle styleForBuilder;
  final bool isNextMonthDay;
  final bool isThisMonthDay;
  final DateTime now;

  final List<int> presentedDays;
  final List<int> absentsDays;
  final List<int> halfDayPresents;

  CalendarItem(
    this.isSelectable,
    this.index,
    this.isSelectedDay,
    this.isToday,
    this.isPrevMonthDay,
    this.styleForBuilder,
    this.isNextMonthDay,
    this.isThisMonthDay,
    this.now,
    this.presentedDays,
    this.absentsDays,
    this.halfDayPresents,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Builder(
          builder: (context) {
            bool isCurrentMonth = !(isPrevMonthDay || isNextMonthDay);
            if (now.weekday == 6 || now.weekday == 7) {
              return DateItemText(
                  now: now, color: isCurrentMonth ? Colors.red : Colors.grey);
            } else if (!isCurrentMonth) {
              return DateItemText(now: now, color: Colors.grey);
            } else if (presentedDays
                .contains(int.parse(DateFormat.d().format(now)))) {
              return WorkingDates(now: now, status: DayStatus.PRESENT);
            } else if (absentsDays
                .contains(int.parse(DateFormat.d().format(now)))) {
              return WorkingDates(now: now, status: DayStatus.ABSENT);
            } else if (halfDayPresents
                .contains(int.parse(DateFormat.d().format(now)))) {
              return WorkingDates(now: now, status: DayStatus.HALFDAY);
            } else
              return DateItemText(now: now, color: Colors.black);
          },
        ),
      ),
    );
  }
}

class WorkingDates extends StatelessWidget {
  const WorkingDates({required this.now, required this.status});
  final DateTime now;
  final DayStatus status;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          DateFormat.d().format(now),
          style: TextStyle(
              fontSize: 14.dynamic,
              color: status.color,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationThickness: 2.0),
        ),
        DatePresentText(status: status),
      ],
    );
  }
}

class DatePresentText extends StatelessWidget {
  final DayStatus? status;
  const DatePresentText({this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.contain,
          child: Text(
            status.text,
            style: TextStyle(
              fontSize: 8.dynamic,
              color: status.color,
            ),
          ),
        ),
      ],
    );
  }
}

class DateItemText extends StatelessWidget {
  DateItemText({this.now, this.color});

  final DateTime? now;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Text(
        DateFormat.d().format(now!),
        style: TextStyle(
          fontSize: 14.dynamic,
          color: color,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
