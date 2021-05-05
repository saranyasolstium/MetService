import 'package:eagle_pixels/api/urls.dart';

extension Method on EndPoint {
  HTTPMethod get method {
    switch (this) {
    }
    return HTTPMethod.post;
  }
}

enum HTTPMethod { get, post }

extension HTTPMethodString on HTTPMethod {
  String get string {
    switch (this) {
      case HTTPMethod.get:
        return "GET";
      case HTTPMethod.post:
        return "POST";
    }
    return "GET";
  }
}
