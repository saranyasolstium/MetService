// To parse this JSON data, do
//
//     final getScheduledList = getScheduledListFromJson(jsonString);

import 'dart:ffi';

import 'package:eagle_pixels/api/api_service.dart';
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
    this.data,
  });

  String? status;
  String? message;
  List<MScheduledJobItem>? data;

  fromJson(Map<String, dynamic> json) {
    var model = ScheduleResponse();
    model.status = json["status"];
    model.message = json["message"];
    model.data = List<MScheduledJobItem>.from(
        json["data"].map((x) => MScheduledJobItem.fromJson(x)));
    return model;
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  bool get isValid => true;
}

class MScheduledJobItem implements AServiceItem {
  MScheduledJobItem({
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

  factory MScheduledJobItem.fromJson(Map<String, dynamic> json) =>
      MScheduledJobItem(
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

  String? get aProductImage => productImage;
  String? get aProdouctName => productName;
  String? get aCctvID => sku.toString();

  String? get aServiceType => '';
  String? get aCustomerName => customerName;
  String? get aCustomerImage => customerImage;

  double? get aLat => lat; //temp
  double? get aLong => long; //temp

  String? get aPurchaseDate => purchaseDate;
  String? get aEndDay => '';
  String? get aRequestNo => '';
  String? get aStartDay => '';
  String? get aServiceID => id.toString();
  String? get aSiteID => siteId.toString();
}
