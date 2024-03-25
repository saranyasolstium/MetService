import 'package:eagle_pixels/api/api_service.dart';

class MClockInResponse implements Codable {
  String? status;
  String? message;
  MClockInItem? data;

  MClockInResponse({this.status, this.message, this.data});

  fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? MClockInItem.fromJson(json['data']) : {})
        as MClockInItem?;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  bool get isValid => data!.attendenceDate != null;
}

class MClockInItem {
  String? attendenceDate;
  String? employeeCode;
  String? siteID;
  int? serviceID;
  String? siteName;
  String? employeeName;
  String? inTimeHour;
  String? inTimeMinute;
  String? latIn;
  String? longIn;
  int? iD;
  Null employeeType;
  MClockInSiteDetail? siteDetails;

  MClockInItem.fromJson(Map<String, dynamic> json) {
    attendenceDate = json['AttendenceDate'];
    employeeCode = json['EmployeeCode'];
    siteID = json['SiteID'];
    serviceID = json['serviceID'];
    siteName = json['SiteName'];
    employeeName = json['EmployeeName'];
    inTimeHour = json['InTime_Hour'];
    inTimeMinute = json['InTime_Minute'];
    latIn = json['LatIn'];
    longIn = json['LongIn'];
    iD = json['ID'];
    employeeType = json['EmployeeType'];
    siteDetails = MClockInSiteDetail.fromJson(json['siteDetails'] ?? {});
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AttendenceDate'] = this.attendenceDate;
    data['EmployeeCode'] = this.employeeCode;
    data['SiteID'] = this.siteID;
    data['serviceID'] = this.serviceID;
    data['SiteName'] = this.siteName;
    data['EmployeeName'] = this.employeeName;
    data['InTime_Hour'] = this.inTimeHour;
    data['InTime_Minute'] = this.inTimeMinute;
    data['LatIn'] = this.latIn;
    data['LongIn'] = this.longIn;
    data['ID'] = this.iD;
    data['EmployeeType'] = this.employeeType;
    if (this.siteDetails != null) {
      data['siteDetails'] = this.siteDetails!.toJson();
    }
    return data;
  }
}

class MClockInSiteDetail {
  int? id;
  // Null location;
  // Null sublocation;
  String? name;
  String? address1;
  Null address2;
  String? country;
  String? state;
  String? city;
  String? zipCode;
  String? status;
  String? createdAt;
  Null updatedAt;

  MClockInSiteDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // location = json['location'];
    // sublocation = json['sublocation'];
    name = json['name'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zip_code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    // data['location'] = this.location;
    // data['sublocation'] = this.sublocation;
    data['name'] = this.name;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
