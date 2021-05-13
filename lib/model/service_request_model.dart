import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/model/abstract_class.dart';

class MServiceRequestResponse implements Codable {
  String status;
  String message;
  List<MServiceRequest> data;

  fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = <MServiceRequest>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(MServiceRequest.fromJson(v));
      });
    }
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool get isValid => data.length > 0;
}

class MServiceRequest implements AServiceItem {
  int id;
  int requesterId;
  int ticketId;
  Null productId;
  Null productItemId;
  String name;
  String subject;
  String description;
  Null attachments;
  String requestDate;
  Null groupId;
  String type;
  int source;
  int priority;
  int siteId;
  Null purchaseId;
  int serviceTypeId;
  String serviceAmount;
  int engineerId;
  String serviceDate;
  String serviceTimeStart;
  String serviceTimeEnd;
  String customerSign;
  int isSynced;
  String createdAt;
  String updatedAt;
  int status;
  int engineerStatus;

  MServiceRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requesterId = json['requester_id'];
    ticketId = json['ticket_id'];
    productId = json['product_id'];
    productItemId = json['product_item_id'];
    name = json['name'];
    subject = json['subject'];
    description = json['description'];
    attachments = json['attachments'];
    requestDate = json['request_date'];
    groupId = json['group_id'];
    type = json['type'];
    source = json['source'];
    priority = json['priority'];
    siteId = json['site_id'];
    purchaseId = json['purchase_id'];
    serviceTypeId = json['service_type_id'];
    serviceAmount = json['service_amount'];
    engineerId = json['engineer_id'];
    serviceDate = json['service_date'];
    serviceTimeStart = json['service_time_start'];
    serviceTimeEnd = json['service_time_end'];
    customerSign = json['customer_sign'];
    isSynced = json['is_synced'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    engineerStatus = json['engineer_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['requester_id'] = this.requesterId;
    data['ticket_id'] = this.ticketId;
    data['product_id'] = this.productId;
    data['product_item_id'] = this.productItemId;
    data['name'] = this.name;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['attachments'] = this.attachments;
    data['request_date'] = this.requestDate;
    data['group_id'] = this.groupId;
    data['type'] = this.type;
    data['source'] = this.source;
    data['priority'] = this.priority;
    data['site_id'] = this.siteId;
    data['purchase_id'] = this.purchaseId;
    data['service_type_id'] = this.serviceTypeId;
    data['service_amount'] = this.serviceAmount;
    data['engineer_id'] = this.engineerId;
    data['service_date'] = this.serviceDate;
    data['service_time_start'] = this.serviceTimeStart;
    data['service_time_end'] = this.serviceTimeEnd;
    data['customer_sign'] = this.customerSign;
    data['is_synced'] = this.isSynced;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['engineer_status'] = this.engineerStatus;
    return data;
  }

  String get aCctvID => productId;
  String get aCustomerName => name; //temp
  String get aImage => 'http//'; //temp
  String get aName => name;
  String get aPurchaseDate => serviceDate; //temp
}
