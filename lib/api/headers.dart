import 'dart:io';

import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/reuse/shared_preference_helper.dart';

extension Header on EndPoint {
  static Map<String, String> get profile {
    Map<String, String> map = {
      'client_secret': 'XHZgV3oFMGAZOzYEG9e9EqWE7OTWECS2MICTjoGX',
      'scope': '',
    };
    return map;
  }

  static Map<String, String> get acceptAndContentType {
    Map<String, String> map = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    return map;
  }

  static Future<Map<String, String>> get defaultHeader async {
    String? token = await SharedPreferencesHelper.getToken();
    Map<String, String> map = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };
    return map;
  }

  static Future<Map<String, String>> get submitJobHeader async {
    String? token = await SharedPreferencesHelper.getToken();
    Map<String, String> map = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };
    return map;
  }

  Future<Map<String, String>> get header async {
    switch (this) {
      case EndPoint.profile:
        return await Header.defaultHeader;
      case EndPoint.login:
        return {};
      case EndPoint.submitJob:
        return await Header.submitJobHeader;
      default:
        return await Header.defaultHeader;
    }
  }
}
