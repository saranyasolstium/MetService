import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/reuse/date_manager.dart';
import 'package:intl/intl.dart';

class MAttendanceEntry implements AJobTime {
  int? iD;
  String? employeeCode;
  dynamic empCode1;
  String? attendenceDate;
  String? attendenceEndDate;
  int? inTimeHour;
  int? inTimeMinute;
  int? outTimeHour;
  int? outTimeMinute;
  dynamic nWorkUnit;
  dynamic jobType;
  dynamic? employeeName;
  dynamic eMPStatus;
  String? siteID;
  int? serviceID;
  String? siteName;
  double? latIn;
  double? longIn;
  double? latOut;
  double? longOut;
  dynamic imageIn;
  dynamic imageOut;
  dynamic isactive;
  dynamic attId;
  int? id;
  // String? employeeCode;
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

  MAttendanceEntry.fromJson(Map<String, dynamic> json) {
    attendenceDate = json['AttendenceDate'];
    if (attendenceDate != null) {
      aStartTime = DateFormat(AppDateFormat.defaultF)
          .parse(attendenceDate!)
          .string(AppDateFormat.attendanceDate);
      print(aStartTime);
    }

    attendenceEndDate = json['AttendenceEndDate'];
    if (attendenceEndDate != null) {
      aEndTime = DateFormat(AppDateFormat.defaultF)
          .parse(attendenceDate!)
          .string(AppDateFormat.attendanceDate);
    }

    iD = json['ID'];
    employeeCode = json['EmployeeCode'];
    empCode1 = json['EmpCode1'];
    inTimeHour = json['InTime_Hour'];
    inTimeMinute = json['InTime_Minute'];

    nWorkUnit = json['nWorkUnit'];
    jobType = json['JobType'];
    aEmployeeName = json['EmployeeName'];
    eMPStatus = json['EMPStatus'];
    siteID = json['SiteID'];
    serviceID = json['serviceID'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['EmployeeCode'] = this.employeeCode;
    data['EmpCode1'] = this.empCode1;
    data['AttendenceDate'] = this.attendenceDate;
    data['AttendenceEndDate'] = this.attendenceEndDate;
    data['InTime_Hour'] = this.inTimeHour;
    data['InTime_Minute'] = this.inTimeMinute;
    data['OutTime_Hour'] = this.outTimeHour;
    data['OutTime_Minute'] = this.outTimeMinute;
    data['nWorkUnit'] = this.nWorkUnit;
    data['JobType'] = this.jobType;
    data['EmployeeName'] = this.aEmployeeName;
    data['EMPStatus'] = this.eMPStatus;
    data['SiteID'] = this.siteID;
    data['serviceID'] = this.serviceID;
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
    return data;
  }

  String? aEndTime;
  String? aStartTime;
  String? aEmployeeName ;
}
