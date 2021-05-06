import 'dart:convert';

import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/model/register_model.dart';

void main() async {
  RegisterRequestModel registerRequestModel = RegisterRequestModel(
      firstName: 'demo',
      lastName: 'acc',
      password: '123456',
      email: 'demo@yopmail.com',
      confirmPassword: '123456',
      countryCode: '+91',
      dob: '01-01-1999',
      mobileNumber: '7410075100',
      userName: 'demouser');
  RegisterResponseModel model;

  var response = await API.service
      .call(endPoint: EndPoint.login, body: registerRequestModel.toJson());
  model = RegisterResponseModel.fromJson(jsonDecode(response.body));
}
