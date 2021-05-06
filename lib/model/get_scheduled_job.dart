// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
