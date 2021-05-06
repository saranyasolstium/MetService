enum EndPoint { profile, login, scheduled_job_list, register }

extension EndPointString on EndPoint {
  String get string {
    switch (this) {
      case EndPoint.profile:
        return "Profile";
      case EndPoint.login:
        return "token";

      case EndPoint.scheduled_job_list:
        return "get_scheduled_job_list?date=2021-02-09";

      case EndPoint.register:
        return "register";
    }
    return "";
  }
}

class APIRouter {
  static EBaseURL baseURL = EBaseURL.debug;

  String url(String endPoint) {
    return baseURL.url(endPoint);
  }
}

enum EBaseURL { debug }

extension BaseURLString on EBaseURL {
  String get base {
    switch (this) {
      case EBaseURL.debug:
        return "https://pixel.solstium.net";
    }
    return "https://pixel.solstium.net";
  }

  String withExtend(String endPoint) {
    var extend = "";
    if (endPoint == EndPoint.login.string) {
      extend = 'oauth';
    } else if (endPoint == EndPoint.register.string) {
      extend = 'api/v1';
    } else {
      extend = "api/v1/employee";
    }
    return "$extend/$endPoint";
  }

  String url(String endPoint) {
    return "${this.base}/${this.withExtend(endPoint)}";
  }
}
