import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/model/abstract_class.dart';

class MScheduleJobDetail implements Codable {
  String? status;
  String? message;
  MJobDetail? data;

  fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = MJobDetail.fromJson(json['data']);
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.toJson() ?? {};
    }
    return data;
  }

  bool get isValid => this.data != null;
}

class MJobDetail implements AJobDetail {
  int? id;
  int? requesterId;
  int? siteId;
  int? ticketId;
  int? productId;
  String? productName;
  String? productImage;
  String? sku;
  String? serialNumber;
  String? subject;
  String? name;
  String? purchaseDate;
  String? poNumber;
  String? serviceDate;
  String? customerName;
  String? customerImage;
  String? scheduledTime;
  String? scheduledBy;
  String? warrantyStatus;
  String? warrantyEnding;
  String? warrantyCard;
  String? description;

  MJobDetail();

  MJobDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requesterId = json['requester_id'];
    siteId = json['site_id'];
    ticketId = json['ticket_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    sku = json['sku'];
    serialNumber = json['serial_number'];
    subject = json['subject'];
    name = json['name'];
    purchaseDate = json['purchase_date'];
    poNumber = json['po_number'];
    serviceDate = json['service_date'];
    customerName = json['customer_name'];
    customerImage = json['customer_image'];
    scheduledTime = json['scheduled_time'];
    scheduledBy = json['scheduled_by'];
    warrantyStatus = json['warranty_status'];
    warrantyEnding = json['warranty_ending'];
    warrantyCard = json['warranty_card'];
    description = json['description'];
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
    data['subject'] = this.subject;
    data['name'] = this.name;
    data['purchase_date'] = this.purchaseDate;
    data['po_number'] = this.poNumber;
    data['service_date'] = this.serviceDate;
    data['customer_name'] = this.customerName;
    data['customer_image'] = this.customerImage;
    data['scheduled_time'] = this.scheduledTime;
    data['scheduled_by'] = this.scheduledBy;
    data['warranty_status'] = this.warrantyStatus;
    data['warranty_ending'] = this.warrantyEnding;
    data['warranty_card'] = this.warrantyCard;
    data['description'] = this.description;
    return data;
  }

  String? get aCameraID => sku; //temp

  String? get aCameraImage => ''; //temp

  String? get aCameraName => name;

  String? get aCustomerInstruction => description;

  String? get aCustomerName => customerName;

  String? get aEndTime => ''; //temp

  String? get aPurchaseDate => purchaseDate;

  String? get aPurchaseOrderNumber => poNumber;

  String? get aScheduleDate => scheduledTime; //temp

  String? get aScheduleTime => scheduledTime;

  String? get aScheduledBy => scheduledBy;

  String? get aStartTime => ''; //temp

  String? get aWarrantyCard => warrantyCard;

  String? get aWarrantyEndingOn => warrantyEnding;

  String? get aWarrantyStatus => warrantyStatus;

  List<ACheckListItem> get checkList => [];

  String? get aDescription => '';

  String? get aPriority => '';

  String? get aSource => '';

  String? get aStatus => '';

  String? get aSubject => '';

  String? get aTicketID => '';

  String? get aSaleOrder => '';

  String? get aSerialNumber => '';

  String? get aSite => '';

  String? get aSubSite => '';

  String? get item => '';

  String? get aItem => ''; //temp
}
