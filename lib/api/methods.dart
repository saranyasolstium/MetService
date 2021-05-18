import 'package:eagle_pixels/api/urls.dart';

enum HTTPMethod { get, post }

extension HTTPMethodString on HTTPMethod {
  String get string {
    switch (this) {
      case HTTPMethod.get:
        return "GET";
      case HTTPMethod.post:
        return "POST";
    }
  }
}

extension Method on EndPoint {
  HTTPMethod get method {
    switch (this) {
      case EndPoint.login:
      case EndPoint.attendance:
      case EndPoint.clockIn:
      case EndPoint.clockOut:
      case EndPoint.attendanceStatus:
      case EndPoint.jobdetail:
      case EndPoint.site:
        return HTTPMethod.post;
      default:
        return HTTPMethod.get;
    }
  }
}
