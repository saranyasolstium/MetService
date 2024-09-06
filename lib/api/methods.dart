import 'package:eagle_pixels/api/urls.dart';

enum HTTPMethod { get, post }

enum ParamType { formData, raw }

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
      case EndPoint.startJob:
      case EndPoint.stopJob:
      case EndPoint.submitJob:
      case EndPoint.completeJob:
      case EndPoint.checkList:
      case EndPoint.getCustomerProductItemList:
        return HTTPMethod.post;
      case EndPoint.getCustomerStoreList:
      case EndPoint.createJob:
        return HTTPMethod.post;
      case EndPoint.updateJob:
        return HTTPMethod.post;
      case EndPoint.availableEngineer:
        return HTTPMethod.post;
      case EndPoint.getCustomerList:
        return HTTPMethod.get;
       case EndPoint.getJobUpdate:
        return HTTPMethod.get;
      default:
        return HTTPMethod.get;
    }
  }

  ParamType get paramType {
    switch (this) {
      case EndPoint.submitJob:
        return ParamType.raw;
      default:
        return ParamType.formData;
    }
  }
}
