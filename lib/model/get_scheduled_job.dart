// To parse this JSON data, do
//
//     final getScheduledList = getScheduledListFromJson(jsonString);

import 'dart:ffi';

import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/constant.dart';
import 'abstract_class.dart';
// ScheduleResponse getScheduledListFromJson(String str) =>
//     ScheduleResponse.fromJson(json.decode(str));
//
// String getScheduledListToJson(ScheduleResponse data) =>
//     json.encode(data.toJson());

class ScheduleResponse implements Codable {
  ScheduleResponse({
    this.status,
    this.message,
    this.data = const [],
  });

  String? status;
  String? message;
  late List<MScheduledJobItem> data;

  fromJson(Map<String, dynamic> json) {
    var model = ScheduleResponse();
    model.status = json["status"];
    model.message = json["message"];

    model.data = [];
    model.data = List<MScheduledJobItem>.from(
        json["data"].map((x) => MScheduledJobItem.fromJson(x)));
    return model;
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  bool get isValid => true;
}

class MScheduledJobItem implements AServiceItem {
  MScheduledJobItem(
      {this.id,
      this.requesterId,
      this.siteId,
      this.ticketId,
      this.productId,
      this.productName,
      this.productImage,
      this.sku,
      this.serialNumber,
      this.purchaseDate,
      this.customerName,
      this.customerImage,
      this.subject,
      this.description,
      this.name,
      this.bookingTime,
      this.bookingDate,
      this.siteAddress,
      this.siteZipCode,
      this.siteState,
      this.siteCity,
      this.engineerStatus,
      this.seviceType,
      this.serviceDate,
      this.attendenceDate,
      this.attendenceEndDate,
      this.employeeName,
      this.latIn,
      this.latOut});

  dynamic? productImage;
  dynamic? productName;
  dynamic? productId;
  dynamic? id;
  dynamic? requesterId;
  dynamic? siteId;
  dynamic? ticketId;
  dynamic? sku;
  dynamic? serialNumber;
  dynamic? purchaseDate;
  dynamic? customerName;
  dynamic? customerImage;
  dynamic? subject;
  dynamic? description;
  dynamic? name;
  dynamic? lat;
  dynamic? long;
  dynamic? siteAddress;
  dynamic? siteCity;
  dynamic? siteState;
  dynamic? siteZipCode;
  dynamic? seviceType;
  int? engineerStatus;
  String? serviceDate;
  dynamic bookingTime;
  dynamic bookingDate;
  dynamic? attendenceDate;
  dynamic? attendenceEndDate;
  dynamic? employeeName;
  dynamic? latIn;
  dynamic? latOut;

  factory MScheduledJobItem.fromJson(Map<String, dynamic> json) =>
      MScheduledJobItem(
        id: json["id"],
        requesterId: json["requester_id"],
        siteId: json["site_id"],
        ticketId: json["ticket_id"],
        productId: json["product_id"],
        productName: json["service_name"],
        productImage: json["product_image"],
        sku: json["sku"],
        bookingDate: json['bookingdate'],
        bookingTime: json['bookingtime'],
        serialNumber: json["serial_number"],
        purchaseDate: json["bookingtime"],
        customerName: json["customer_name"],
        customerImage: json["customer_image"],
        subject: json["subject"],
        description: json["description"],
        name: json["name"],
        siteAddress: json["site_address"],
        siteCity: json["site_city"],
        siteState: json["site_state"],
        siteZipCode: json["site_zipcode"],
        engineerStatus: json["engineer_status"],
        seviceType: json["service"],
        serviceDate: json["service_date"],
        //Attendance entry
        attendenceDate: json['AttendenceDate'],
        attendenceEndDate: json['AttendenceEndDate'],
        employeeName: json['EmployeeName'],
        latIn: json['LatIn'],
        latOut: json['LatOut'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "requester_id": requesterId,
        "site_id": siteId,
        "ticket_id": ticketId,
        "product_id": productId,
        "service_name": productName,
        "product_image": productImage,
        "sku": sku,
        "bookingtime": bookingTime,
        "bookingdate": bookingDate,
        "serial_number": serialNumber,
        "purchase_date": purchaseDate,
        "customer_name": customerName,
        "customer_image": customerImage,
        "subject": subject,
        "description": description,
        "name": name,
        "service": seviceType,
        //AttendanceEntry
        'AttendenceDate': attendenceDate,
        'AttendenceEndDate': attendenceEndDate,
        'EmployeeName': employeeName,
        'LatIn': latIn,
        'LatOut': latOut,
      };

  String? get aProductImage => productImage;
  String? get aProdouctName => productName;
  String? get aCctvID => sku.toString();

  String? get aServiceType => seviceType;
  String? get aCustomerName => customerName;
  String? get aCustomerImage => customerImage;
  String? get aEmail => "";
  String? get aPhoneNo => "";
  String? get aServiceName => "";
  String? get aSubServiceName => "";

  double? get aLat => lat;
  double? get aLong => long;

  String? get aPurchaseDate => purchaseDate;
  String? get aEndDay => '';
  String? get aRequestNo => '';
  String? get aStartDay => '';
  String? get aServiceID => id.toString();
  String? get aScheduleTime => bookingDate.toString();

  String? get aCombinedAddress =>
      constructAddress([siteAddress, siteCity, siteState, siteZipCode]);

  String? get aSiteID => siteId.toString();

  String? get aEmployeeName => siteId.toString();

  double? get aLatIn => 0;

  double? get aLatOut => 0;
}
