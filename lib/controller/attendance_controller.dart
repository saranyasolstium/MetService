import 'dart:core';
import 'dart:ui';

import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/model/attendance_model.dart';
import 'package:eagle_pixels/model/clockin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../colors.dart';
import 'package:eagle_pixels/api/api_service.dart';

class AttendanceController extends GetxController {
  var selectedYear = "2021".obs;
  var selectedMonth = "01".obs;

  var jobStartedTime = DateTime.now().obs;

  var attendance = Map<String, List<MAttendanceItem>>();
  AAttendanceStatus attendanceStatus;
  @override
  void onInit() {
    selectedMonth.value = DateFormat.MMMM().format(DateTime.now());
    selectedYear.value = DateFormat.y().format(DateTime.now());
    super.onInit();
  }

  resetAttendance() {
    attendanceStatus = null;
    selectedMonth.value = DateFormat.MMMM().format(DateTime.now());
    selectedYear.value = DateFormat.y().format(DateTime.now());
  }

  bool get isClockedIn {
    return false; //attendanceStatus.startedDate;
  }

  Future<MClockInResponse> onClockIn() async {
    var body = {'SiteID': 0, 'latitude': 0, 'longitude': 0, 'serviceID': 0};

    var response = await API.service.call(
      model: MClockInResponse(),
      endPoint: EndPoint.clockIn,
      body: body,
    );
    return response.model;
  }

  bool get isAttendanceHereForSelected {
    var selectedDayAttendance =
        attendance['${selectedMonth.value}${selectedYear.value}'];
    return (selectedDayAttendance != null && selectedDayAttendance.length > 0);
  }

  fetchAttendance({@required bool isShowLoading}) async {
    var month = this.selectedMonth.value;
    var year = this.selectedYear.value;
    var response = await API.service.call(
      model: MAttendanceResponse(),
      endPoint: EndPoint.attendance,
      needLoader: isShowLoading,
      body: {
        'month': month,
        'year': year,
      },
    );
    if (response.isValidModel) {
      attendance['$month$year'] = response.model.data;
    }
    update();
  }

  List<int> presentedDays() {
    var days = <int>[];
    var attendanceInSelectedMonth =
        attendance['${selectedYear.value}${selectedYear.value}'];
    if (attendanceInSelectedMonth != null &&
        attendanceInSelectedMonth.length > 0) {
      attendanceInSelectedMonth.forEach((element) {
        if (element.inTimeHour != null && element.outTimeHour != null) {
          if (element.outTimeHour - element.inTimeHour > 4) {
            var elementDate =
                DateFormat('yyyy-MM-dd HH:mm:ss').parse(element.attendenceDate);
            days.add(elementDate.day);
          }
        }
      });
    }
    return days;
  }

  List<int> absentDays() {
    var days = <int>[];
    var attendanceInSelectedMonth =
        attendance['${selectedYear.value}${selectedYear.value}'];
    if (attendanceInSelectedMonth != null &&
        attendanceInSelectedMonth.length > 0) {
      attendanceInSelectedMonth.forEach((element) {
        if (element.inTimeHour != null && element.outTimeHour != null) {
          if (element.outTimeHour - element.inTimeHour > 4) {
            var elementDate =
                DateFormat('yyyy-MM-dd HH:mm:ss').parse(element.attendenceDate);
            days.add(elementDate.day);
          }
        }
      });
    }
    return days;
  }

  List<int> halfPresentedDays() {
    var days = <int>[];
    var attendanceInSelectedMonth =
        attendance['${selectedYear.value}${selectedYear.value}'];
    if (attendanceInSelectedMonth != null &&
        attendanceInSelectedMonth.length > 0) {
      attendanceInSelectedMonth.forEach((element) {
        if (element.inTimeHour != null && element.outTimeHour != null) {
          if (element.outTimeHour - element.inTimeHour < 4) {
            var elementDate =
                DateFormat('yyyy-MM-dd HH:mm:ss').parse(element.attendenceDate);
            days.add(elementDate.day);
          }
        }
      });
    }
    return days;
  }
}

enum DayStatus {
  PRESENT,
  ABSENT,
  HALFDAY,
}

extension StatusExtension on DayStatus {
  Color get color {
    switch (this) {
      case DayStatus.ABSENT:
        return HexColor.fromHex('#D85151');
      case DayStatus.PRESENT:
        return HexColor.fromHex('#14E19C');
      case DayStatus.HALFDAY:
        return HexColor.fromHex('#EFD100');
    }
    return Colors.black;
  }

  String get text {
    switch (this) {
      case DayStatus.ABSENT:
        return 'ABSENT';
      case DayStatus.PRESENT:
        return 'PRESENT';
      case DayStatus.HALFDAY:
        return 'HALF DAY';
    }
    return '';
  }
}
