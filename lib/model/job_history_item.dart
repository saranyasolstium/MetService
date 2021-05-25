import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/model/abstract_class.dart';

class MJobHistoryListResponse implements Codable {
  String? status;
  String? message;
  List<MJobHistoryItem>? data;

  fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = <MJobHistoryItem>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(new MJobHistoryItem().fromJson(v));
      });
    }
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool get isValid => true;
}

class MJobHistoryItem implements AServiceItem {
  int? id;
  int? requesterId;
  String? siteId;
  int? ticketId;
  String? productId;
  String? productName;
  String? productImage;
  String? sku;
  String? serialNumber;
  String? purchaseDate;
  String? customerName;
  String? customerImage;
  String? subject;
  String? description;
  String? name;
  int? engineerStatus;
  String? status;

  fromJson(Map<String, dynamic> json) {
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
    customerName = json['customer_name'];
    customerImage = json['customer_image'];
    subject = json['subject'];
    description = json['description'];
    name = json['name'];
    engineerStatus = json['engineer_status'];
    status = json['status'];
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
    data['customer_name'] = this.customerName;
    data['customer_image'] = this.customerImage;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['name'] = this.name;
    data['engineer_status'] = this.engineerStatus;
    data['status'] = this.status;
    return data;
  }

  String? get aCctvID => productId;
  String? get aCustomerName => customerName;
  String? get aImage => productImage;
  String? get aName => productName;
  String? get aPurchaseDate => purchaseDate;

  String? get aEndDay => '';

  String? get aRequestNo => '';

  String? get aStartDay => '';

  String? get aServiceType => '';
}
