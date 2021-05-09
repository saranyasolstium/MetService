// To parse this JSON data, do
//
//     final getScheduledList = getScheduledListFromJson(jsonString);

import 'dart:convert';

import 'package:eagle_pixels/api/api_service.dart';

// ScheduleResponse getScheduledListFromJson(String str) =>
//     ScheduleResponse.fromJson(json.decode(str));
//
// String getScheduledListToJson(ScheduleResponse data) =>
//     json.encode(data.toJson());

class ScheduleResponse implements Codable {
  ScheduleResponse({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<ScheduleList> data;

  fromJson(Map<String, dynamic> json) {
    var model = ScheduleResponse();
    model.status = json["status"];
    model.message = json["message"];
    model.data = List<ScheduleList>.from(
        json["data"].map((x) => ScheduleList.fromJson(x)));
    return model;
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  bool get isValid => true;
}

class ScheduleList {
  ScheduleList({
    this.id,
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
  });

  int id;
  int requesterId;
  int siteId;
  int ticketId;
  dynamic productId;
  String productName;
  String productImage;
  String sku;
  String serialNumber;
  String purchaseDate;
  String customerName;
  String customerImage;
  String subject;
  String description;
  String name;

  factory ScheduleList.fromJson(Map<String, dynamic> json) => ScheduleList(
        id: json["id"],
        requesterId: json["requester_id"],
        siteId: json["site_id"],
        ticketId: json["ticket_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        productImage: json["product_image"],
        sku: json["sku"],
        serialNumber: json["serial_number"],
        purchaseDate: json["purchase_date"],
        customerName: json["customer_name"],
        customerImage: json["customer_image"],
        subject: json["subject"],
        description: json["description"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "requester_id": requesterId,
        "site_id": siteId,
        "ticket_id": ticketId,
        "product_id": productId,
        "product_name": productName,
        "product_image": productImage,
        "sku": sku,
        "serial_number": serialNumber,
        "purchase_date": purchaseDate,
        "customer_name": customerName,
        "customer_image": customerImage,
        "subject": subject,
        "description": description,
        "name": name,
      };
}
