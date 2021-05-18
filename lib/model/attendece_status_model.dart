// To parse this JSON data, do
//
//     final attendanceStatus = attendanceStatusFromJson(jsonString);

import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/reuse/date_manager.dart';
import 'package:intl/intl.dart';

// AttendanceStatus attendanceStatusFromJson(String str) =>
//     AttendanceStatus.fromJson(json.decode(str));
//
// String attendanceStatusToJson(AttendanceStatus data) =>
//     json.encode(data.toJson());

class MAttendanceStatusResponse implements Codable, AAttendanceStatus {
  String? status;
  MAttendanceStatusItem? data;

  MAttendanceStatusResponse fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = MAttendanceStatusItem.fromJson(json["data"]);
    startedDate = data?.attendenceDate;
    return this;
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };

  @override
  bool get isValid => status?.isSuccess ?? false;

  @override
  DateTime? startedDate;
}

class MAttendanceStatusItem {
  int? id;
  String? employeeCode;
  dynamic empCode1;
  DateTime? attendenceDate;
  int? inTimeHour;
  int? inTimeMinute;
  dynamic outTimeHour;
  dynamic outTimeMinute;
  dynamic nWorkUnit;
  dynamic jobType;
  String? employeeName;
  dynamic? empStatus;
  String? siteId;
  int? serviceId;
  dynamic siteName;
  int? latIn;
  int? longIn;
  dynamic latOut;
  dynamic longOut;
  dynamic imageIn;
  dynamic imageOut;
  dynamic isactive;
  dynamic attId;
  int? dataId;
  String? dataEmployeeCode;
  String? firstName;
  dynamic joiningDate;
  String? lastName;
  String? userName;
  String? email;
  String? designation;
  dynamic networkUserId;
  String? countryCode;
  int? mobileNumber;
  String? registerationDate;
  dynamic dob;
  String? department;
  dynamic employeeType;
  dynamic finNumber;
  String? finStartDate;
  String? finEndDate;
  dynamic passportNumber;
  dynamic passportStartDate;
  dynamic passportEndDate;
  String? finCertificate;
  String? passportCertificate;
  String? profileImage;
  dynamic status;
  dynamic deletedAt;
  dynamic siteDetails;

  MAttendanceStatusItem.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    employeeCode = json['EmployeeCode'];
    empCode1 = json['EmpCode1'];
    attendenceDate =
        DateFormat(AppDateFormat.defaultF).parse(json['AttendenceDate']);
    inTimeHour = json['InTime_Hour'];
    inTimeMinute = json['InTime_Minute'];
    outTimeHour = json['OutTime_Hour'];
    outTimeMinute = json['OutTime_Minute'];
    nWorkUnit = json['nWorkUnit'];
    jobType = json['JobType'];
    employeeName = json['EmployeeName'];
    empStatus = json['EMPStatus'];
    siteId = json['SiteID'];
    serviceId = json['serviceID'];
    siteName = json['SiteName'];
    latIn = json['LatIn'];
    longIn = json['LongIn'];
    latOut = json['LatOut'];
    longOut = json['LongOut'];
    imageIn = json['ImageIn'];
    imageOut = json['ImageOut'];
    isactive = json['isactive'];
    attId = json['att_id'];
    id = json['id'];
    employeeCode = json['employee_code'];
    firstName = json['first_name'];
    joiningDate = json['joining_date'];
    lastName = json['last_name'];
    userName = json['user_name'];
    email = json['email'];
    designation = json['designation'];
    networkUserId = json['network_user_id'];
    countryCode = json['country_code'];
    mobileNumber = json['mobile_number'];
    registerationDate = json['registeration_date'];
    dob = json['dob'];
    department = json['department'];
    employeeType = json['employee_type'];
    finNumber = json['fin_number'];
    finStartDate = json['fin_start_date'];
    finEndDate = json['fin_end_date'];
    passportNumber = json['passport_number'];
    passportStartDate = json['passport_start_date'];
    passportEndDate = json['passport_end_date'];
    finCertificate = json['fin_certificate'];
    passportCertificate = json['passport_certificate'];
    profileImage = json['profile_image'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    siteDetails = json['siteDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['EmployeeCode'] = this.employeeCode;
    data['EmpCode1'] = this.empCode1;
    data['AttendenceDate'] = this.attendenceDate;
    data['InTime_Hour'] = this.inTimeHour;
    data['InTime_Minute'] = this.inTimeMinute;
    data['OutTime_Hour'] = this.outTimeHour;
    data['OutTime_Minute'] = this.outTimeMinute;
    data['nWorkUnit'] = this.nWorkUnit;
    data['JobType'] = this.jobType;
    data['EmployeeName'] = this.employeeName;
    data['EMPStatus'] = this.empStatus;
    data['SiteID'] = this.siteId;
    data['serviceID'] = this.serviceId;
    data['SiteName'] = this.siteName;
    data['LatIn'] = this.latIn;
    data['LongIn'] = this.longIn;
    data['LatOut'] = this.latOut;
    data['LongOut'] = this.longOut;
    data['ImageIn'] = this.imageIn;
    data['ImageOut'] = this.imageOut;
    data['isactive'] = this.isactive;
    data['att_id'] = this.attId;
    data['id'] = this.id;
    data['employee_code'] = this.employeeCode;
    data['first_name'] = this.firstName;
    data['joining_date'] = this.joiningDate;
    data['last_name'] = this.lastName;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['designation'] = this.designation;
    data['network_user_id'] = this.networkUserId;
    data['country_code'] = this.countryCode;
    data['mobile_number'] = this.mobileNumber;
    data['registeration_date'] = this.registerationDate;
    data['dob'] = this.dob;
    data['department'] = this.department;
    data['employee_type'] = this.employeeType;
    data['fin_number'] = this.finNumber;
    data['fin_start_date'] = this.finStartDate;
    data['fin_end_date'] = this.finEndDate;
    data['passport_number'] = this.passportNumber;
    data['passport_start_date'] = this.passportStartDate;
    data['passport_end_date'] = this.passportEndDate;
    data['fin_certificate'] = this.finCertificate;
    data['passport_certificate'] = this.passportCertificate;
    data['profile_image'] = this.profileImage;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['siteDetails'] = this.siteDetails;
    return data;
  }
}
