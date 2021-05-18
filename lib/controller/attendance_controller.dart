import 'dart:core';
import 'dart:ui';

import 'package:eagle_pixels/api/urls.dart';

import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/model/attendance_model.dart';
import 'package:eagle_pixels/model/attendece_status_model.dart';
import 'package:eagle_pixels/model/clockin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../colors.dart';
import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/reuse/Keys.dart';

class AttendanceController extends GetxController {
  var selectedYear = "2021".obs;
  var selectedMonth = "January".obs;
  String selectedMonthInNumber = '1';

  DateTime get selectedDate {
    return DateTime(
        int.parse(selectedYear.value), int.parse(selectedMonthInNumber));
  }

  DateTime? get jobStartedTime {
    return attendanceStatus.value?.startedDate;
  }

  var attendance = Map<String, List<MAttendanceItem>?>();
  final Rx<AAttendanceStatus?> attendanceStatus =
      MAttendanceStatusResponse().obs;
  @override
  void onInit() {
    selectedMonth.value = DateFormat.MMMM().format(DateTime.now());
    selectedYear.value = DateFormat.y().format(DateTime.now());
    super.onInit();
  }

  resetAttendance() {
    attendanceStatus.value = null;
    selectedMonth.value = DateFormat.MMMM().format(DateTime.now());
    selectedYear.value = DateFormat.y().format(DateTime.now());
  }

  bool get isClockedIn {
    return jobStartedTime != null;
  }

  bool get isAttendanceHereForSelected {
    var selectedDayAttendance =
        attendance['${selectedMonth.value}${selectedYear.value}'];
    return (selectedDayAttendance != null && selectedDayAttendance.length > 0);
  }

  List<int> presentedDays() {
    var days = <int>[];
    var attendanceInSelectedMonth =
        attendance['${selectedYear.value}${selectedYear.value}'];
    if (attendanceInSelectedMonth != null &&
        attendanceInSelectedMonth.length > 0) {
      attendanceInSelectedMonth.forEach((element) {
        if (element.inTimeHour != null && element.outTimeHour != null) {
          if (element.outTimeHour! - element.inTimeHour! > 4) {
            var elementDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                .parse(element.attendenceDate!);
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
          if (element.outTimeHour! - element.inTimeHour! > 4) {
            var elementDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                .parse(element.attendenceDate!);
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
          if (element.outTimeHour! - element.inTimeHour! < 4) {
            var elementDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                .parse(element.attendenceDate!);
            days.add(elementDate.day);
          }
        }
      });
    }
    return days;
  }
}

extension AttendanceControllerService on AttendanceController {
  fetchAttendance({required bool isShowLoading}) async {
    var month = this.selectedMonthInNumber;
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
      attendance['$month$year'] = response.model!.data;
    }
    update();
  }

  Future<MClockInResponse?> onClockIn() async {
    var body = {
      'SiteID': '0',
      'latitude': '0',
      'longitude': '0',
      'serviceID': '0'
    };

    var response = await API.service.call(
      model: MClockInResponse(),
      endPoint: EndPoint.clockIn,
      body: body,
    );
    return response.model;
  }

  Future<MClockInResponse?> onClockOut() async {
    var body = {
      'SiteID': '0',
      'latitude': '0',
      'longitude': '0',
      'serviceID': '0'
    };

    var response = await API.service.call(
      model: MClockInResponse(),
      endPoint: EndPoint.clockOut,
      body: body,
    );
    return response.model;
  }

  fetchAttendanceStatus() async {
    var response = await API.service.call(
        model: MAttendanceStatusResponse(),
        endPoint: EndPoint.attendanceStatus,
        body: {K.service_id: '0'} //temp
        );
    attendanceStatus.value = response.model;
  }
}

enum DayStatus {
  PRESENT,
  ABSENT,
  HALFDAY,
}

extension StatusExtension on DayStatus? {
  Color get color {
    switch (this) {
      case DayStatus.ABSENT:
        return HexColor.fromHex('#D85151');
      case DayStatus.PRESENT:
        return HexColor.fromHex('#14E19C');
      case DayStatus.HALFDAY:
        return HexColor.fromHex('#EFD100');
      default:
        return Colors.black;
    }
  }

  String get text {
    switch (this) {
      case DayStatus.ABSENT:
        return 'ABSENT';
      case DayStatus.PRESENT:
        return 'PRESENT';
      case DayStatus.HALFDAY:
        return 'HALF DAY';
      default:
        return "";
    }
  }
}
