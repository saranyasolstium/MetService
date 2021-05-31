import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/model/abstract_class.dart';

class MActiveServiceResponse extends Codable {
  String? status;
  String? message;
  late List<MActiveService> data;

  MActiveServiceResponse fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(MActiveService.fromJson(v));
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
  String? subject;
  String? description;
  String? name;

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

  String? get aCctvID => id.toString();
  String? get aCustomerImage => customerImage;
  String? get aCustomerName => customerName;
  String? get aEndDay => '';

  double? get aLat => 0;
  double? get aLong => 0;
  String? get aProdouctName => name;
  String? get aProductImage => productImage;
  String? get aPurchaseDate => purchaseDate;
  String? get aRequestNo => requesterId.toString();
  String? get aServiceType => '';
  String? get aStartDay => '';
  List<AJobTime>? aAttendanceEntry;
}
