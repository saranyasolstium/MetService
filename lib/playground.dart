import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pretty_json/pretty_json.dart';

void main() async {
  // RegisterRequestModel registerRequestModel = RegisterRequestModel(
  //     firstName: 'demo',
  //     lastName: 'acc',
  //     password: '123456',
  //     email: 'demo@yopmail.com',
  //     confirmPassword: '123456',
  //     countryCode: '+91',
  //     dob: '01-01-1999',
  //     mobileNumber: '7410075100',
  //     userName: 'demouser');
  // RegisterResponseModel model;
  //
  // var response = await API.service
  //     .call(endPoint: EndPoint.login, body: registerRequestModel.toJson());
  // model = RegisterResponseModel.fromJson(jsonDecode(response.body));
  // var date = DateFormat.M().format(DateTime.now());
  // var year = DateFormat.y().format(DateTime.now());
  // print(date);
  // print(year);

  // var resp = await http.get(Uri.parse('https://reqres.in/api/unknown'));
  // var response = APIResponse(Resource(), resp).model;
  // print('${response.data.map((e) => e.name)}');
}
