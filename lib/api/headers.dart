import 'package:eagle_pixels/api/urls.dart';

extension Header on EndPoint {
  static Map<String, String> get defaultHeader {
    Map<String, String> map = {
      'client_secret': 'XHZgV3oFMGAZOzYEG9e9EqWE7OTWECS2MICTjoGX',
      'scope': '',
    };
    return map;
  }

  Map<String, String> get header {
    switch (this) {
      case EndPoint.profile:
        return Header.defaultHeader;
      case EndPoint.login:
        return {};
    }
  }
}
