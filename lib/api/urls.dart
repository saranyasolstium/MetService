enum EndPoint {
  profile,
  login,
  scheduled_job_list,
  register,
  job_history_list,
  attendance,
  clockIn,
  clockOut,
  checkList,
  attendanceStatus,
  jobdetail,
  site,
  startJob,
  stopJob,
  submitJob,
  completeJob,
  activeJob,
  getCustomerList,
  getCustomerProductItemList,
  getCustomerStoreList,
  //serviceTypeList,
  oppoinmentList,
  productSales,
  customerProduct,
  serviceLists,
  subServicelists,
  availableEngineer,
  createJob,
}

extension EndPointString on EndPoint {
  String get string {
    switch (this) {
      case EndPoint.profile:
        return "profile";
      case EndPoint.login:
        return "login";
      case EndPoint.scheduled_job_list:
        return "get_scheduled_job_list";
      case EndPoint.register:
        return "register";
      case EndPoint.job_history_list:
        return 'get_job_history_list';
      case EndPoint.attendance:
        return 'monthattendencelist';
      case EndPoint.clockIn:
        return 'clockin';
      case EndPoint.clockOut:
        return 'clockout';
      case EndPoint.checkList:
        return 'get_service_checklistinfo';
      case EndPoint.attendanceStatus:
        return 'timecard';
      case EndPoint.jobdetail:
        return 'get_scheduled_job_details';
      case EndPoint.site:
        return 'storelist';
      case EndPoint.startJob:
        return 'start_job';
      case EndPoint.stopJob:
        return 'stop_job';
      case EndPoint.submitJob:
        return 'service_report';
      case EndPoint.completeJob:
        return 'complete_job';
      case EndPoint.activeJob:
        return 'get_date_job_list';
      case EndPoint.getCustomerList:
        return 'customer_list';
      case EndPoint.getCustomerProductItemList:
        return 'customer_item_list';
      // case EndPoint.serviceTypeList:
      //   return 'get_servicetype_list';
      case EndPoint.createJob:
        return 'create_serviceRequest';
      case EndPoint.getCustomerStoreList:
        return 'customer_storelist';
      case EndPoint.oppoinmentList:
        return 'getOppoinmentRequest';
      case EndPoint.productSales:
        return 'getProductSales';
      case EndPoint.customerProduct:
        return 'getCustomerProduct';
      case EndPoint.serviceLists:
        return 'servicelists';
      case EndPoint.subServicelists:
        return 'sub_servicelists';
      case EndPoint.availableEngineer:
        return 'getAvailableEngineer';
    }
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
        return "https://met.solstium.net";
    }
  }

  String withExtend(String endPoint) {
    var extend = "";
    if (endPoint == EndPoint.login.string) {
      extend = 'api/v1';
    } else if (endPoint == EndPoint.register.string) {
      extend = 'api/v1';
    } else if (endPoint == EndPoint.profile.string) {
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
