import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/model/abstract_class.dart';

class MShowAttendenceResponse implements Codable {
  String? status;
  String? message;
  List<MShowAttendenceDetail>? data;

  fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MShowAttendenceDetail>[];
      json['data'].forEach((v) {
        data?.add(new MShowAttendenceDetail.fromJson(v));
      });
    }
    return this;
  }

  bool get isValid => this.data != null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MShowAttendenceDetail implements AShowAttendance {
  int? id;
  int? requesterId;
  int? siteId;
  int? ticketId;
  int? productId;
  String? productName;
  String? productImage;
  String? sku;
  String? serialNumber;
  Null purchaseDate;
  String? companyName;
  String? customerName;
  String? customerImage;
  String? subject;
  String? description;
  String? name;

  MShowAttendenceDetail();

  MShowAttendenceDetail.fromJson(Map<String, dynamic> json) {
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
    customerName = json['customer_name'];
    customerImage = json['customer_image'];
    subject = json['subject'];
    description = json['description'];
    name = json['name'];
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
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['name'] = this.name;
    return data;
  }

  String? get aCctvID => '';

  String? get aCustomerName => customerName;

  String? get aEndDay => '';

  String? get aImage => '';

  String? get aProductName => productName;

  String? get aServiceReqNo => '';

  String? get aStartDay => '';

  String? get aCustomerImage => customerImage;
}
