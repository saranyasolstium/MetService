import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/model/attendance_entry_model.dart';
// class MScheduleJobDetail implements Codable {
//   String? status;
//   String? message;
//   MJobDetail? data;
//
//   fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = MJobDetail.fromJson(json['data']);
//     return this;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data?.toJson() ?? {};
//     }
//     return data;
//   }
//
//   bool get isValid => this.data != null;
// }
//
// class MJobDetail implements AJobDetail {
//   int? id;
//   int? requesterId;
//   int? siteId;
//   int? ticketId;
//   int? productId;
//   String? productName;
//   String? productImage;
//   String? sku;
//   String? serialNumber;
//   String? subject;
//   String? name;
//   String? purchaseDate;
//   String? poNumber;
//   String? serviceDate;
//   String? customerName;
//   String? customerImage;
//   String? scheduledTime;
//   String? scheduledBy;
//   String? warrantyStatus;
//   String? warrantyEnding;
//   String? warrantyCard;
//   String? description;
//
//   MJobDetail();
//
//   MJobDetail.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     requesterId = json['requester_id'];
//     siteId = json['site_id'];
//     ticketId = json['ticket_id'];
//     productId = json['product_id'];
//     productName = json['product_name'];
//     productImage = json['product_image'];
//     sku = json['sku'];
//     serialNumber = json['serial_number'];
//     subject = json['subject'];
//     name = json['name'];
//     purchaseDate = json['purchase_date'];
//     poNumber = json['po_number'];
//     serviceDate = json['service_date'];
//     customerName = json['customer_name'];
//     customerImage = json['customer_image'];
//     scheduledTime = json['scheduled_time'];
//     scheduledBy = json['scheduled_by'];
//     warrantyStatus = json['warranty_status'];
//     warrantyEnding = json['warranty_ending'];
//     warrantyCard = json['warranty_card'];
//     description = json['description'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['requester_id'] = this.requesterId;
//     data['site_id'] = this.siteId;
//     data['ticket_id'] = this.ticketId;
//     data['product_id'] = this.productId;
//     data['product_name'] = this.productName;
//     data['product_image'] = this.productImage;
//     data['sku'] = this.sku;
//     data['serial_number'] = this.serialNumber;
//     data['subject'] = this.subject;
//     data['name'] = this.name;
//     data['purchase_date'] = this.purchaseDate;
//     data['po_number'] = this.poNumber;
//     data['service_date'] = this.serviceDate;
//     data['customer_name'] = this.customerName;
//     data['customer_image'] = this.customerImage;
//     data['scheduled_time'] = this.scheduledTime;
//     data['scheduled_by'] = this.scheduledBy;
//     data['warranty_status'] = this.warrantyStatus;
//     data['warranty_ending'] = this.warrantyEnding;
//     data['warranty_card'] = this.warrantyCard;
//     data['description'] = this.description;
//     return data;
//   }
//
//   String? get aCameraID => sku;
//
//   String? get aCameraImage => '';
//
//   String? get aCameraName => name;
//
//   String? get aCustomerInstruction => description;
//
//   String? get aCustomerName => customerName;
//
//   String? get aEndTime => '';
//
//   String? get aPurchaseDate => purchaseDate;
//
//   String? get aPurchaseOrderNumber => poNumber;
//
//   String? get aScheduleDate => scheduledTime;
//
//   String? get aScheduleTime => scheduledTime;
//
//   String? get aScheduledBy => scheduledBy;
//
//   String? get aStartTime => '';
//
//   String? get aWarrantyCard => warrantyCard;
//
//   String? get aWarrantyEndingOn => warrantyEnding;
//
//   String? get aWarrantyStatus => warrantyStatus;
//
//   List<ACheckListItem> get checkList => [];
//
//   String? get aDescription => '';
//
//   String? get aPriority => '';
//
//   String? get aSource => '';
//
//   String? get aStatus => '';
//
//   String? get aSubject => '';
//
//   String? get aTicketID => '';
//
//   String? get aSaleOrder => '';
//
//   String? get aSerialNumber => '';
//
//   String? get aSite => '';
//
//   String? get aSubSite => '';
//
//   String? get item => '';
//
//   String? get aItem => '';
// }

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

// extension MJobDetailWithActiveService on MJobDetail extends AActiveService {}

class MJobDetail implements AJobDetail, AActiveService {
  int? id;
  int? requesterId;
  int? siteId;
  int? ticketId;
  int? productId;
  String? productName;
  String? productImage;
  String? sku;
  String? serialNumber;
  String? priority;
  String? status;
  String? source;
  String? subject;
  String? description;
  String? name;
  String? purchaseDate;
  String? poNumber;
  String? serviceDate;
  String? companyName;
  String? customerName;
  String? customerImage;
  String? siteName;
  String? subsiteName;
  String? saleOrder;
  String? siteMap;
  String? scheduledTime;
  String? scheduledBy;
  String? warrantyStatus;
  String? warrantyEnding;
  String? vendorWarranty;
  String? serviceType;
  String? serviceAmount;
  int? engineerStatus;
  String? warrantyCard;
  String? aAddress;
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
    priority = json['priority'];
    status = json['status'];
    source = json['source'];
    subject = json['subject'];
    description = json['description'];
    name = json['name'];
    purchaseDate = json['purchase_date'];
    poNumber = json['po_number'];
    serviceDate = json['service_date'];
    companyName = json['company_name'];
    customerName = json['customer_name'];
    customerImage = json['customer_image'];
    siteName = json['site_name'];
    subsiteName = json['subsite_name'];
    saleOrder = json['sale_order'];
    siteMap = json['site_map'];
    scheduledTime = json['scheduled_time'];
    scheduledBy = json['scheduled_by'];
    warrantyStatus = json['warranty_status'];
    warrantyEnding = json['warranty_ending'];
    vendorWarranty = json['vendor_warranty'];
    serviceType = json['service_type'];
    serviceAmount = json['service_amount'];
    engineerStatus = json['engineer_status'];
    warrantyCard = json['warranty_card'];
    aAddress = json['site_address'];

    final attendance = json['attendance'];
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
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['source'] = this.source;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['name'] = this.name;
    data['purchase_date'] = this.purchaseDate;
    data['po_number'] = this.poNumber;
    data['service_date'] = this.serviceDate;
    data['company_name'] = this.companyName;
    data['customer_name'] = this.customerName;
    data['customer_image'] = this.customerImage;
    data['site_name'] = this.siteName;
    data['subsite_name'] = this.subsiteName;
    data['sale_order'] = this.saleOrder;
    data['site_map'] = this.siteMap;
    data['scheduled_time'] = this.scheduledTime;
    data['scheduled_by'] = this.scheduledBy;
    data['warranty_status'] = this.warrantyStatus;
    data['warranty_ending'] = this.warrantyEnding;
    data['vendor_warranty'] = this.vendorWarranty;
    data['service_type'] = this.serviceType;
    data['service_amount'] = this.serviceAmount;
    data['engineer_status'] = this.engineerStatus;
    data['warranty_card'] = this.warrantyCard;
    return data;
  }

  String? get aCameraID => sku;

  String? get aCameraImage => productImage;

  String? get aCameraName => productName;

  String? get aCustomerImage => customerImage;

  String? get aCustomerName => customerName;

  String? get aDescription => description;

  String? get aFloorPlan => siteMap;

  String? get aItem => '';

  String? get aPriority => priority;

  String? get aSaleOrder => saleOrder;

  String? get aSerialNumber => serialNumber;

  String? get aService => warrantyStatus;

  String? get aServiceAmount => serviceAmount;

  String? get aSite => siteName;

  String? get aSiteMapLat => '';

  String? get aSiteMapLang => '';

  String? get aSource => source;

  String? get aStatus => status;

  String? get aSubSite => subsiteName;

  String? get aSubject => subject;

  String? get aTicketID => ticketId.toString();

  String? get aTypeOfService => serviceType;

  List<ACheckListItem> get checkList => [];

  String? get aServiceId => id.toString();

  List<AJobTime>? aAttendanceEntry;

  String? address;

  String? get aCctvID => sku.toString();

  String? get aEndDay => '';

  double? get aLat => 0;

  double? get aLong => 0;

  String? get aProdouctName => productName;

  String? get aProductImage => productImage;

  String? get aPurchaseDate => purchaseDate;

  String? get aRequestNo => requesterId.toString();

  String? get aServiceType => serviceType;

  String? get aStartDay => '';
  String? get aServiceID => id.toString();
  String? get aSiteID => siteId.toString();
}
