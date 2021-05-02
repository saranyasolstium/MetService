import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/login_model.dart';

enum EndPoint {
  profile,
  login,
}

extension EndPointRawValue on EndPoint {
  String get rawValue {
    switch (this) {
      case EndPoint.profile:
        return "Profile";
      case EndPoint.login:
        return "login";
    }
    return "";
  }
}

class APIManager {
  void some(EndPoint url) {
    some(EndPoint.profile);
  }
  //Request Parameters
  /*
  1. Url
  2. header
  3. parameter or body
  4. encoding - safe to send data
  5. Methods - get, post, delete, Multipart
   */

  Future<http.Response> serviceCall() {}
}

class APIService {
  static final shared = APIService();
  static Map<String, String> headers() {
    Map<String, String> map = {
      'client_secret': 'XHZgV3oFMGAZOzYEG9e9EqWE7OTWECS2MICTjoGX',
      'scope': ''
    };
    return map;
  }

  Future login(LoginRequestModel requestModel) async {
    Uri url = Uri.parse('https://pixel.solstium.net/oauth/token');
    try {
      final http.Response response =
          await http.post(url, body: requestModel.toJson(), headers: headers());
      print('Login response');
      if (response.statusCode == 200 || response.statusCode == 400) {
        String data = response.body;
        print(data);
        return LoginResponseModel.fromJson(
          jsonDecode(data),
        );
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print('Failed to load data!$error');
    }
  }
}
