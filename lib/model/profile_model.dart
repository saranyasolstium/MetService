// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

import 'package:eagle_pixels/api/api_service.dart';

// Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
//
// String profileToJson(Profile data) => json.encode(data.toJson());

class MProfileResponse implements Codable {
  MProfileResponse({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<MProfile> data;

  fromJson(Map<String, dynamic> json) {
    var model = MProfileResponse();
    model.status = json["status"];
    model.message = json["message"];
    model.data =
        List<MProfile>.from(json["data"].map((x) => MProfile.fromJson(x)));
    return model;
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
  bool get isValid {
    return (data != null && data.length > 0);
  }
}

class MProfile {
  MProfile({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.userType,
    this.role,
    this.employeeCode,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.joiningDate,
    this.totalCompletedJobs,
    this.totalServiceDays,
    this.employeeDetails,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  int userType;
  String role;
  String employeeCode;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic joiningDate;
  int totalCompletedJobs;
  int totalServiceDays;
  MEmployeeDetails employeeDetails;

  factory MProfile.fromJson(Map<String, dynamic> json) => MProfile(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        userType: json["user_type"],
        role: json["role"],
        employeeCode: json["employee_code"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        joiningDate: json["joining_date"],
        totalCompletedJobs: json["total_completed_jobs"],
        totalServiceDays: json["total_service_days"],
        employeeDetails: MEmployeeDetails.fromJson(json["employeeDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "user_type": userType,
        "role": role,
        "employee_code": employeeCode,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "joining_date": joiningDate,
        "total_completed_jobs": totalCompletedJobs,
        "total_service_days": totalServiceDays,
        "employeeDetails": employeeDetails.toJson(),
      };
}

class MEmployeeDetails {
  MEmployeeDetails({
    this.id,
    this.firstName,
    this.lastName,
    this.employeeCode,
    this.userName,
    this.designation,
    this.countryCode,
    this.mobileNumber,
    this.registerationDate,
    this.department,
    this.employeeType,
    this.finNumber,
    this.finStartDate,
    this.finEndDate,
    this.passportNumber,
    this.passportStartDate,
    this.passportEndDate,
    this.finCertificate,
    this.passportCertificate,
    this.profileImage,
  });

  int id;
  String firstName;
  String lastName;
  String employeeCode;
  String userName;
  String designation;
  String countryCode;
  int mobileNumber;
  DateTime registerationDate;
  String department;
  dynamic employeeType;
  dynamic finNumber;
  DateTime finStartDate;
  DateTime finEndDate;
  dynamic passportNumber;
  dynamic passportStartDate;
  dynamic passportEndDate;
  String finCertificate;
  String passportCertificate;
  String profileImage;

  factory MEmployeeDetails.fromJson(Map<String, dynamic> json) =>
      MEmployeeDetails(
        id: json["ID"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        employeeCode: json["employee_code"],
        userName: json["user_name"],
        designation: json["designation"],
        countryCode: json["country_code"],
        mobileNumber: json["mobile_number"],
        registerationDate: DateTime.parse(json["registeration_date"]),
        department: json["department"],
        employeeType: json["employee_type"],
        finNumber: json["fin_number"],
        finStartDate: DateTime.parse(json["fin_start_date"]),
        finEndDate: DateTime.parse(json["fin_end_date"]),
        passportNumber: json["passport_number"],
        passportStartDate: json["passport_start_date"],
        passportEndDate: json["passport_end_date"],
        finCertificate: json["fin_certificate"],
        passportCertificate: json["passport_certificate"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "first_name": firstName,
        "last_name": lastName,
        "employee_code": employeeCode,
        "user_name": userName,
        "designation": designation,
        "country_code": countryCode,
        "mobile_number": mobileNumber,
        "registeration_date": registerationDate.toIso8601String(),
        "department": department,
        "employee_type": employeeType,
        "fin_number": finNumber,
        "fin_start_date":
            "${finStartDate.year.toString().padLeft(4, '0')}-${finStartDate.month.toString().padLeft(2, '0')}-${finStartDate.day.toString().padLeft(2, '0')}",
        "fin_end_date":
            "${finEndDate.year.toString().padLeft(4, '0')}-${finEndDate.month.toString().padLeft(2, '0')}-${finEndDate.day.toString().padLeft(2, '0')}",
        "passport_number": passportNumber,
        "passport_start_date": passportStartDate,
        "passport_end_date": passportEndDate,
        "fin_certificate": finCertificate,
        "passport_certificate": passportCertificate,
        "profile_image": profileImage,
      };
}
