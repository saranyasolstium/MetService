import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/model/attendance_entry_model.dart';
import 'package:eagle_pixels/reuse/date_manager.dart';
import 'package:intl/intl.dart';

class MActiveServiceResponse extends Codable {
  String? status;
  String? message;
  late List<MActiveService> data;
  List<ServiceDetail>? serviceDetails;

  MActiveServiceResponse fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(MActiveService.fromJson(v));
      });
    }

    if (json['service_details'] != null) {
      // Parse service_details if available
      serviceDetails = <ServiceDetail>[];
      json['service_details'].forEach((v) {
        serviceDetails?.add(new ServiceDetail.fromJson(v));
      });
    }
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data.map((v) => v.toJson()).toList();

    return data;
  }

  bool get isValid => data.length > 0;
}

class MActiveService extends AActiveService {
  int? id;
  int? requesterId;
  int? siteId;
  int? ticketId;
  int? productId;
  String? productName;
  String? productImage;
  String? sku;
  String? serialNumber;
  dynamic? purchaseDate;
  String? companyName;
  String? customerName;
  String? customerImage;
  String? email;
  String? phone;
  String? serviceName;
  String? subserviceName;
  String? subject;
  String? description;
  String? name;
  String? attendenceDate;
  String? attendenceEndDate;
  String? employeeName;
  double? latIn;
  double? latOut;

  MActiveService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requesterId = json['requester_id'];
    siteId = json['site_id'];
    ticketId = json['ticket_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    sku = json['sku'];
    serialNumber = json['serial_number'];
    purchaseDate = json['purchase_date'];
    companyName = json['company_name'];
    //customer infomation
    customerName = json['customer_name'];
    customerImage = json['customer_image'];
    email = json['customer_email'];
    phone = json['phone'];
    serviceName = json['service_name'];
    subserviceName = json['subservice_name'];

    subject = json['subject'];
    description = json['description'];
    name = json['name'];
    aAddress = json['site_address'];
    final attendance = json['AttendenceDate'];
    print(attendance);

    if (attendance != null) {
      DateTime utcStartTime = DateTime.parse(attendance + "Z").toLocal();
      DateTime attendanceDateTime =
          DateTime.tryParse(utcStartTime.toString()) ?? DateTime.now();
      attendenceDate =
          DateFormat(AppDateFormat.scheduledTime).format(attendanceDateTime);
    } 
    // else {
    //   attendenceDate = "N/A";
    // }

    if (json['AttendenceEndDate'] != null) {
      DateTime utcEndTime =
          DateTime.parse(json['AttendenceEndDate'] + "Z").toLocal();

      DateTime attendanceEndDateTime =
          DateTime.tryParse(utcEndTime.toString()) ?? DateTime.now();
      attendenceEndDate =
          DateFormat(AppDateFormat.scheduledTime).format(attendanceEndDateTime);
    } else {
      attendenceEndDate = "N/A";
    }

    employeeName = json['EmployeeName'];
    latIn = json['LatIn'];
    latOut = json['LatOut'];
    aAttendanceEntry = [];

    if (attendance != null && attendance is List<dynamic>) {
      try {
        (attendance).forEach((e) {
          aAttendanceEntry!.add(MAttendanceEntry.fromJson(e));
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['requester_id'] = this.requesterId;
    data['site_id'] = this.siteId;
    data['ticket_id'] = this.ticketId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['sku'] = this.sku;
    data['serial_number'] = this.serialNumber;
    data['purchase_date'] = this.purchaseDate;
    data['company_name'] = this.companyName;
    data['customer_name'] = this.customerName;
    data['customer_image'] = this.customerImage;
    data['customer_email'] = this.email;
    data['phone'] = this.phone;
    data['service_name'] = this.serviceName;
    data['subservice_name'] = this.subserviceName;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['name'] = this.name;
    //AttendanceEntry
    data['AttendenceDate'] = this.attendenceDate;
    data['AttendenceEndDate'] = this.attendenceEndDate;
    data['EmployeeName'] = this.employeeName;
    data['LatIn'] = this.latIn;
    data['LatOut'] = this.latOut;
    return data;
  }

  String? get aCctvID => sku.toString();

  String? get aCustomerImage => customerImage;

  String? get aCustomerName => customerName;

  String? get aEmail => email;

  String? get aPhoneNo => phone;

  String? get aServiceName => serviceName;

  String? get aSubServiceName => subserviceName;

  String? get aEndDay => attendenceEndDate.toString();

  double? get aLat => 0;
  double? get aLong => 0;
  String? get aProdouctName => name;
  String? get aProductImage => productImage;
  String? get aPurchaseDate => purchaseDate;
  String? get aRequestNo => requesterId.toString();
  String? get aStartDay => attendenceDate.toString();

  List<AJobTime>? aAttendanceEntry;
  String? get aServiceID => id.toString();
  String? get aSiteID => siteId.toString();
  String? get aCombinedAddress => aAddress;
  String? get aEmployeeName => employeeName.toString();

  double? get aLatIn => latIn ?? 0;

  double? get aLatOut => latOut ?? 0;

  // String? get aCombinedAddress => '$siteAddress $siteCity $siteState $siteZipCode';
}

class ServiceDetail {
  // Define the ServiceDetail class
  int? id;
  // String? employeeCode;
  // String? employeeName;
  String? serviceStartDate;
  String? serviceEndDate;
  // double? latIn;
  // double? latOut;
  // Add other properties as needed

  ServiceDetail(); // Constructor

  ServiceDetail.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    // employeeCode = json['EmployeeCode'];
    // employeeName = json['EmployeeName'];
    //Attendance entry
    
    
    DateTime utcStartTime =
        DateTime.parse(json['job_time_start'] + "Z").toLocal();
    DateTime attendanceDateTime =
        DateTime.tryParse(utcStartTime.toString()) ?? DateTime.now();
    serviceStartDate =
        DateFormat(AppDateFormat.scheduledTime).format(attendanceDateTime);
        print(serviceStartDate);

    if (json['job_time_end'] != null) {
      DateTime utcEndTime =
          DateTime.parse(json['job_time_end'] + "Z").toLocal();

      DateTime attendanceEndDateTime =
          DateTime.tryParse(utcEndTime.toString()) ?? DateTime.now();
      serviceEndDate =
          DateFormat(AppDateFormat.scheduledTime).format(attendanceEndDateTime);
          print(serviceEndDate);
    } else {
      serviceEndDate = "N/A";
    }
    
    // Parse other properties
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    //data['EmployeeCode'] = this.employeeCode;
    //data['EmployeeName'] = this.employeeName;
    data['job_time_start'] = this.serviceStartDate;
    data['job_time_end'] = this.serviceEndDate;
   
    // Add other properties
    return data;
  }
}
