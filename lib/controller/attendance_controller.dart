import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../colors.dart';

class AttendanceController extends GetxController {
  var month = MonthData().obs;
  var selectedYear = "2021".obs;
  var selectedMonth = "01".obs;
  var jobStartedTime = DateTime.now().obs;
  @override
  void onInit() {
    selectedMonth.value = DateFormat.MMMM().format(DateTime.now());
    selectedYear.value = DateFormat.y().format(DateTime.now());
    fetchAttendance();
    super.onInit();
  }

  bool get clockIn {
    return false;
  }

  // onClockIn() async {
  //   var response =
  // }

  fetchAttendance() {
    update();
  }
}

class MonthData {}

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
