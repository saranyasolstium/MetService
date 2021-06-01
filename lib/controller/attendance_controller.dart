import 'dart:core';
import 'dart:io';
import 'dart:ui';

import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/controller/app_controller.dart';

import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/model/attendance_model.dart';
import 'package:eagle_pixels/model/attendece_status_model.dart';
import 'package:eagle_pixels/model/show_attendence_model.dart';
import 'package:eagle_pixels/model/clockin_model.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:eagle_pixels/model/site_model.dart';
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
import 'package:eagle_pixels/common/logger.dart';
import 'package:eagle_pixels/model/active_service_model.dart';

class VerificationData {
  late bool isLocalAuthed;
  late File selectedImage;
  late Position location;
}

class AttendanceController extends GetxController {
  static AttendanceController get to => Get.find<AttendanceController>();
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

  var arrActiveService = <AActiveService>[].obs;

  final viewState = ViewState.loading.obs;

  //ShowAttendanceModel
  Rx<AShowAttendance> showAttendenceDetail = MShowAttendenceDetail().obs;

  var arrSite =
      <MSite>[].obs; //Attendance engineer use the site for mark the attendance.
  late Rx<MSite?> selectedSite = Rx(null);

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
    var status = (attendanceStatus.value as MAttendanceStatusResponse).data;
    if (status != null) {
      return jobStartedTime != null &&
          status.siteId == '0' &&
          status.serviceId == 0;
    } else {
      return false;
    }
    // return jobStartedTime != null && attendanceStatus.value.startedDate;
  }

  bool get isAllowForClockIn {
    var status = (attendanceStatus.value as MAttendanceStatusResponse).data;
    if (status != null) {
      return !(jobStartedTime != null &&
          status.siteId != '0' &&
          status.serviceId != 0);
    } else {
      return true;
    }
  }

  bool isShowStop({required String siteID, required String serviceID}) {
    var status = (attendanceStatus.value as MAttendanceStatusResponse).data;
    if (status != null) {
      return (jobStartedTime != null &&
          status.siteId == siteID &&
          status.serviceId.toString() == serviceID);
    } else {
      return false;
    }
  }

  bool get isAttendanceHereForSelected {
    var selectedDayAttendance =
        attendance['${selectedMonth.value}${selectedYear.value}'];
    return (selectedDayAttendance != null && selectedDayAttendance.length > 0);
  }

  var presentedDayInSelectedMonth = <int>[];

  // List<int> presentedDays() {
  //   var days = <int>[];
  //   var attendanceInSelectedMonth =
  //       attendance['${selectedYear.value}${selectedYear.value}'];
  //   Logger.log('PresentedDay', 'count ${10}');
  //   if (attendanceInSelectedMonth != null &&
  //       attendanceInSelectedMonth.length > 0) {
  //     attendanceInSelectedMonth.forEach((element) {
  //       // if (element.inTimeHour != null && element.outTimeHour != null) {
  //       //   if (element.outTimeHour! - element.inTimeHour! > 4) {
  //       var elementDate =
  //           DateFormat('yyyy-MM-dd HH:mm:ss').parse(element.attendenceDate!);
  //       days.add(elementDate.day);
  //       // }
  //       // }
  //     });
  //   }
  //   return days;
  // }

  // List<int> absentDays() {
  //   var days = <int>[];
  //   var attendanceInSelectedMonth =
  //       attendance['${selectedYear.value}${selectedYear.value}'];
  //   if (attendanceInSelectedMonth != null &&
  //       attendanceInSelectedMonth.length > 0) {
  //     attendanceInSelectedMonth.forEach((element) {
  //       if (element.inTimeHour != null && element.outTimeHour != null) {
  //         if (element.outTimeHour! - element.inTimeHour! > 4) {
  //           var elementDate = DateFormat('yyyy-MM-dd HH:mm:ss')
  //               .parse(element.attendenceDate!);
  //           days.add(elementDate.day);
  //         }
  //       }
  //     });
  //   }
  //   return days;
  // }

  // List<int> halfPresentedDays() {
  //   var days = <int>[];
  //   var attendanceInSelectedMonth =
  //       attendance['${selectedYear.value}${selectedYear.value}'];
  //   if (attendanceInSelectedMonth != null &&
  //       attendanceInSelectedMonth.length > 0) {
  //     attendanceInSelectedMonth.forEach((element) {
  //       if (element.inTimeHour != null && element.outTimeHour != null) {
  //         if (element.outTimeHour! - element.inTimeHour! < 4) {
  //           var elementDate = DateFormat('yyyy-MM-dd HH:mm:ss')
  //               .parse(element.attendenceDate!);
  //           days.add(elementDate.day);
  //         }
  //       }
  //     });
  //   }
  //   return days;
  // }

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

  String get attendanceStoreKey {
    return '${selectedMonth.value}${selectedYear.value}';
  }

  // Future<VerificationData> onVerifyUser() {}

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

  bool setCurrentPresentedDay() {
    presentedDayInSelectedMonth.clear();
    var monthData = attendance[attendanceStoreKey];
    if (monthData != null) {
      Logger.log('Attendance', 'Data count - ${monthData.length}');
      monthData.forEach((day) {
        var elementDate =
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(day.attendenceDate!);
        presentedDayInSelectedMonth.add(elementDate.day);
      });
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}

extension AttendanceControllerService on AttendanceController {
  fetchAttendance({required bool isShowLoading}) async {
    if (!setCurrentPresentedDay()) {
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
        attendance[attendanceStoreKey] = response.model!.data;
        setCurrentPresentedDay();
      }
    }
  }

  Future<MClockInResponse?> onClockIn() async {
    try {
      final siteID = AppController.to.isAttendanceEngineer
          ? "${selectedSite.value?.id ?? 0}"
          : "0";
      Position position = await AppController.to.determinePosition();
      var body = {
        'SiteID': siteID,
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
        body: {K.service_id: '0'});
    attendanceStatus.value = response.model;
  }

  // fetchShowAttendenceDetail() async {
  //   var response = await API.service.call(
  //       model: MShowAttendenceResponse(),
  //       endPoint: EndPoint.jobdetail,
  //       body: {K.job_id: '1'} //temp
  //       );
  //
  //   if (response.isValidModel) {
  //     showAttendenceDetail.value = response.model!.data! as AShowAttendance;
  //   }
  // }

  fetchService() async {
    viewState.value = ViewState.loading;
    var res = await API.service.call(
      model: MActiveServiceResponse(),
      endPoint: EndPoint.activeJob,
    );
    if (res.isValidModel) {
      arrActiveService.value = res.model!.data;
      viewState.value = ViewState.success;
    }
  }

  fetchSite() async {
    var response = await API.service.call(
        model: MSiteResponse(),
        endPoint: EndPoint.site,
        body: {K.service_id: '2'} //temp
        );

    if (response.isValidModel) {
      arrSite.value = response.model!.data!;
      selectedSite.value = arrSite.first;
    }
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
