import 'dart:core';
import 'dart:ui';

import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/controller/app_controller.dart';

import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/model/attendance_model.dart';
import 'package:eagle_pixels/model/attendece_status_model.dart';
import 'package:eagle_pixels/model/clockin_model.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/auth_strings.dart';

import '../colors.dart';
import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/reuse/Keys.dart';

import 'package:local_auth/local_auth.dart';

import '../constant.dart';

class AttendanceController extends GetxController {
  var selectedYear = "2021".obs;
  var selectedMonth = "January".obs;
  String selectedMonthInNumber = '1';

  DateTime get selectedDate {
    return DateTime(
        int.parse(selectedYear.value), int.parse(selectedMonthInNumber));
  }

  DateTime? get jobStartedTime {
    // print(attendanceStatus.value?.startedDate);
    return attendanceStatus.value?.startedDate?.toLocal();
  }

  var arrService = <AServiceItem>[].obs;

  final viewState = ViewState.loading.obs;

  fetchService() async {
    viewState.value = ViewState.loading;

    Future.delayed(Duration(seconds: 2), () {
      arrService.add(MScheduledJobItem());
      viewState.value = ViewState.success;
    });
  }

  var attendance = Map<String, List<MAttendanceItem>?>();
  final Rx<AAttendanceStatus?> attendanceStatus =
      MAttendanceStatusResponse().obs;
  @override
  void onInit() {
    selectedMonth.value = DateFormat.MMMM().format(DateTime.now());
    selectedYear.value = DateFormat.y().format(DateTime.now());
    _getAllBiometrics();
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

  var _localAuth = LocalAuthentication();
  var hasFingerPrintLock = false.obs;
  var hasFaceLock = false.obs;
  var isUserAuthenticated = false.obs;

  void _getAllBiometrics() async {
    // Check whether there is local authentication available on this device or not
    final isAvailable = await _localAuth.canCheckBiometrics;
    final isDeviceSupported = await _localAuth.isDeviceSupported();
    bool hasLocalAuthentication = await _localAuth.canCheckBiometrics;
    if (isAvailable && isDeviceSupported) {
      if (hasLocalAuthentication) {
        List<BiometricType> availableBiometrics =
            await _localAuth.getAvailableBiometrics();
        hasFaceLock.value = availableBiometrics.contains(BiometricType.face);
        hasFingerPrintLock.value =
            availableBiometrics.contains(BiometricType.fingerprint);
      } else {
        showSnackBar(
            title: "Error",
            message: 'Local Authentication not available',
            backgroundColor: Colors.red);
      }
    } else {
      showSnackBar(
          title: "Error",
          message: 'Local Authentication not available',
          backgroundColor: Colors.red);
    }
  }

  void showSnackBar(
      {required String title,
      required String message,
      Color? backgroundColor}) {
    Get.snackbar(title, message,
        colorText: Colors.white,
        backgroundColor: backgroundColor,
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<bool> authenticateUser() async {
    try {
      const androidMessage = const AndroidAuthMessages(
        cancelButton: 'Cancel',
        goToSettingsButton: 'settings',
        goToSettingsDescription: 'Please set up your Fingerprint/Face.',
        biometricHint: 'Verify your identity',
      );
      isUserAuthenticated.value = await _localAuth.authenticate(
        localizedReason: 'Authenticate Yourself',
        biometricOnly: false,
        useErrorDialogs: true,
        stickyAuth: true,
        androidAuthStrings: androidMessage,
      );
      if (isUserAuthenticated.value) {
        return true;
        // showSnackBar(
        //     title: "Success",
        //     message: "You are authenticated",
        //     backgroundColor: Colors.green);
      } else {
        showSnackBar(
            title: "Error",
            message: "Authentication Cancelled",
            backgroundColor: Colors.red);
        return false;
      }
    } on Exception catch (e) {
      print(e);
      showSnackBar(
          title: "Error", message: e.toString(), backgroundColor: Colors.red);
      return false;
    }
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
    try {
      Position position = await AppController.to.determinePosition();
      var body = {
        'SiteID': '0',
        'latitude': '${position.latitude}',
        'longitude': '${position.longitude}',
        'serviceID': '0'
      };

      var response = await API.service.call(
        model: MClockInResponse(),
        endPoint: EndPoint.clockIn,
        body: body,
      );
      return response.model;
    } catch (error) {
      print('$error');
    }
  }

  Future<MClockInResponse?> onClockOut() async {
    Position position = await AppController.to.determinePosition();
    var body = {
      'SiteID': '0',
      'latitude': '${position.latitude}',
      'longitude': '${position.longitude}',
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
