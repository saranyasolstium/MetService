import 'dart:io';

import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/reuse/storage.dart';

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
      // 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI2IiwianRpIjoiNzJmNzM3YjkzMTdhMTlhYTY4ZDQ3ODJjMTM2YjIwZmQyMWE5ZjMxZjg3NDZmODg1ZWJkNzY0Mzk5MTFlMjg0NTlkZTU1ZjVkNDJjOGFhOTAiLCJpYXQiOjE2MjAzMjYxNDYsIm5iZiI6MTYyMDMyNjE0NiwiZXhwIjoxNjIxNjIyMTQ2LCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.oBOINC5mgo8m0QuMwYL5Su8ZJptP2BVmQFy_doJsCVMwYkMFiJR6N0q2zp-pNc12xBPnIxVLy0j0pHEIo2grXk5OAntnveaQ1fMA_g0wZ6SVFuW-SM7i4QEpUUtobBZK6BZBZuUe1AiYlCQ_fB6P_KRf7VaRBs9jySbYoQj4ytU9Z6DCmdGQktS5RgnkBc4DfaJ8bsMVqar3cKUSkzBoOW0S4OkZKW4UFgRHoyPwHredzKD0faWKMY96Q3-fzObbMRmSojaEuM-iOMLW4w8gCqpztx8cuaNCp3iFdUcJs6DJWaSR0Ajsavzm4p7Q01u-mm7Jm0QMTb1Reek9a5VM00mIZtRfn8tWiQAGWwpn8B7Gtk7epGf7qn9vHp-i6xQOPx0kcnzyUHLa_HxSGPUIvOqZRTLf388_RLaqa3UOz3yR23E1_ky9jysaDiNjtbVIY2iouAlpGQB1ZtbRnj_OTnEEuxF7md9-Q_DGdQoZTSDEmee6idY6ikp_1JREqKUGxTXHuqOsM3hIDprZbWcGdnU6968_cI1UGX0bWWJB7TxJy7iZKTUsD9oC7dWNYkgVOQYXPnhP2Ed_92eMP-L1neX6n3Ka9RvcOrjxE258lz9oPIFAIwCNeE9k9K4eUlIUP7u1eTXHyalbbPYKdV7nXsq5nXC0hnVvLmIibOYCukU'
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
