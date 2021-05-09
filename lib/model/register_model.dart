// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

// RegisterResponseModel welcomeFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));
//
// String welcomeToJson(RegisterResponseModel data) => json.encode(data.toJson());
import 'package:eagle_pixels/api/api_service.dart';

class RegisterResponseModel implements Codable {
  RegisterResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<dynamic> data;

  fromJson(Map<String, dynamic> json) {
    var model = RegisterResponseModel();
    model.status = json["status"];
    model.message = json["message"];
    return model;
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        // "data": List<dynamic>.from(data.map((x) => x)),
      };
  bool get isValid => true;
}

class RegisterRequestModel {
  String email;
  String password;
  String firstName;
  String lastName;
  String dob;
  String countryCode;
  String mobileNumber;
  String confirmPassword;
  String userName;

  RegisterRequestModel(
      {this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.confirmPassword,
      this.dob,
      this.countryCode,
      this.mobileNumber,
      this.userName});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'first_name': firstName.trim(),
      'last_name': lastName.trim(),
      'dob': dob,
      'email': email.trim(),
      'country_code': countryCode.trim(),
      'mobile_number': mobileNumber.trim(),
      'password': password.trim(),
      'confirm_password': confirmPassword.trim(),
      'user_name': userName.trim(),
    };
    return map;
  }
}
