import 'dart:io';

import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/reuse/storage.dart';
import 'package:get_storage/get_storage.dart';

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

  static Map<String, String> get defaultHeader {
    Map<String, String> map = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          'Bearer ${AppController.to.storage.token}'
    };
    return map;
  }

  Map<String, String> get header {
    switch (this) {
      case EndPoint.profile:
        return Header.defaultHeader;
      case EndPoint.login:
        return {};
      default:
        Header.defaultHeader;
    }
    return Header.defaultHeader;
  }
}
