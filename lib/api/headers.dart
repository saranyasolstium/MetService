import 'dart:io';

import 'package:eagle_pixels/api/urls.dart';

extension Header on EndPoint {
  static Map<String, String> get loginHeader {
    Map<String, String> map = {
      'client_secret': 'XHZgV3oFMGAZOzYEG9e9EqWE7OTWECS2MICTjoGX',
      'scope': '',
    };
    return map;
  }

  static Map<String, String> get defaultHeader {
    return {
      // HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      // 'client_secret': 'XHZgV3oFMGAZOzYEG9e9EqWE7OTWECS2MICTjoGX',
    };
  }

  Map<String, String> get header {
    switch (this) {
      case EndPoint.register:
        return Header.defaultHeader;
      case EndPoint.login:
        return Header.loginHeader;
    }
    return {};
  }
}
