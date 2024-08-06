import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/model/attendance_entry_model.dart';
import 'package:eagle_pixels/common/logger.dart';
import 'package:intl/intl.dart';

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
  String? email;
  String? phone;
  String? serviceName;
  String? subserviceName;
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
  dynamic? siteAddress;
  dynamic? siteCity;
  dynamic? siteState;
  dynamic? siteZipCode;

  dynamic? teamName;
  dynamic? bookingDate;
  dynamic? bookingTime;
  dynamic? amount;
  dynamic formattedBookingDate;

  String? attendenceDate;
  String? attendenceEndDate;
  String? employeeName;
  double? latIn;
  double? latOut;

  String? attention;
  String? customerType;
  String? serviceOrderNo;

  String? ServiceCover;
  String? treatmentMethod;
  String? serviceFrequency;
  String? degreeInfestation;

  String? preparation;
  String? billingType;
  String? referralName;
  String? decisionMaker;
  String? estimationFirstService;
  String? servicePremiseAddress;
  String? businessSource;
  String? seeOnSite;

  MJobDetail();

  MJobDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    requesterId = json['requester_id'];
    Logger.log("requester", requesterId.toString());
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
    //customer infomation
    customerName = json['name'];
    customerImage = json['customer_image'];
    email = json['customer_email'];

    phone = json['customer_phone'];
    serviceName = json['service_name'];
    // subserviceName = json['subservice_name'];
    final List<dynamic>? subserviceList = json['subservice_name'];
    if (subserviceList != null && subserviceList.isNotEmpty) {
      subserviceName =
          subserviceList.map((e) => e['subservice_name'].toString()).join(', ');
    }

    print(subserviceName);
    // //Booking Information
    teamName = json['service_type'];
    bookingDate = json['service_date'];
    DateTime bookingDateTime = DateTime.tryParse(bookingDate) ?? DateTime.now();
    formattedBookingDate = DateFormat('dd MMMM yyyy').format(bookingDateTime);
    bookingTime = json['scheduled_time'];
    amount = json['service_amount'];
    print(amount);
    //Attendance entry
    attendenceDate = json['AttendenceDate'];
    attendenceEndDate = json['AttendenceEndDate'];
    employeeName = json['EmployeeName'];
    latIn = json['LatIn'];
    latOut = json['LatOut'];

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

    siteAddress = json["address"];
    siteCity = json["site_city"];
    siteState = json["site_state"];
    siteZipCode = json["site_zipcode"];

    ServiceCover = json["service_cover"];
    treatmentMethod = json["treatment_method"];
    serviceFrequency = json["service_frequency"];
    degreeInfestation = json["degree_infestation"];

    preparation = json["preparation"];
    billingType = json["billing_type"];
    referralName = json["referral_name"];
    estimationFirstService = json["estimation_first_service"];
    servicePremiseAddress = json["service_premise_address"];
    businessSource=json['business_source'];
    seeOnSite = json["see_on_site"];
    decisionMaker = json["decision_maker"];

    attention = json["attention"];
    customerType = json["customer_type"];
    print('saranya');
    print(json["attention"]);

    serviceOrderNo = json["service_order_id"];

    final attendance = json['attendance'];
    aAttendanceEntry = [];

    if (attendance != null) {
      try {
        (attendance).forEach((e) {
          aAttendanceEntry!.add(MAttendanceEntry.fromJson(e));
        });
      } catch (e) {
        print(e);
      }
    }
    Logger.log('Attendance Entry Count', '${aAttendanceEntry!.length}');
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
    data['name'] = this.customerName;
    data['address'] = this.siteAddress;
    data['purchase_date'] = this.purchaseDate;
    data['po_number'] = this.poNumber;
    data['service_date'] = this.serviceDate;
    data['company_name'] = this.companyName;
    data['name'] = this.customerName;
    data['customer_image'] = this.customerImage;
    data['customer_email'] = this.email;
    data['customer_phone'] = this.phone;
    data['service_name'] = this.serviceName;
    data['subservice_name'] = this.subserviceName;

    data['attention'] = this.attention;
    data['customer_type'] = this.customerType;
    data['service_order_id'] = this.serviceOrderNo;

    // //Booking Information
    data['service_type'] = this.teamName;
    data['service_date'] = this.bookingDate;
    data['scheduled_time'] = this.bookingTime;
    data['service_amount'] = this.amount;

    data["service_cover"] = this.ServiceCover;
    data["treatment_method"] = this.treatmentMethod;
    data["service_frequency"] = this.serviceFrequency;
    data["degree_infestation"] = this.degreeInfestation;
    data["preparation"] = this.preparation;
    data["billing_type"] = this.billingType;
    data["referral_name"] = this.referralName;
    data["estimation_first_service"] = this.estimationFirstService;
    data["service_premise_address"] = this.servicePremiseAddress;
    data['business_source']=this.businessSource;
    data["see_on_site"] = this.seeOnSite;
    data["decision_maker"] = this.decisionMaker;

    //AttendanceEntry
    data['AttendenceDate'] = this.attendenceDate;
    data['AttendenceEndDate'] = this.attendenceEndDate;
    data['EmployeeName'] = this.employeeName;
    data['LatIn'] = this.latIn;
    data['LatOut'] = this.latOut;

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

  String? get aEmail => email;

  String? get aPhoneNo => phone != null ? "+65 " + phone! : "NA";

  String? get aServiceName => serviceName;

  String? get aSubServiceName => subserviceName;

  String? get aTeamName => teamName;

  String? get aBookingDate => formattedBookingDate;

  String? get aBookingTime => bookingTime;

  String? get aBookingAmount => amount;

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

  String? get aEndDay => attendenceEndDate;

  double? get aLat => 0;

  double? get aLong => 0;

  String? get aProdouctName => productName;

  String? get aProductImage => productImage;

  String? get aPurchaseDate => purchaseDate;

  String? get aRequestNo => requesterId.toString();

  //String? get aServiceType => serviceType;

  String? get aStartDay => attendenceDate.toString();
  String? get aServiceID => id.toString();
  String? get aSiteID => siteId.toString();
  String? get aCombinedAddress => siteAddress;
  //constructAddress([siteAddress, siteCity, siteState, siteZipCode]);

  String? get aAttention => attention;

  String? get aCustomerType => customerType;

  String? get aServiceOrderNo => serviceOrderNo;

  String? get aFloorPlanName => subsiteName;

  String? get aEmployeeName => employeeName.toString();

  double? get aLatIn => latIn ?? 0;

  double? get aLatOut => latOut ?? 0;

  String? get aServiceCover => ServiceCover;

  String? get aTreatmentMethod => treatmentMethod;

  String? get aServiceFrequency => serviceFrequency;

  String? get aDegreeInfestation => degreeInfestation;

  String? get aPreparation => preparation;
  String? get aBillingType => billingType;
  String? get aReferralName => referralName;
  String? get aDecisionMaker => decisionMaker;
  String? get aEstimationFirstService => estimationFirstService;
  String? get aServicePremiseAddress => servicePremiseAddress;
  String? get aBusinessSource => businessSource;
  String? get aSeeOnSite => seeOnSite;

  int? get aEnginnerStatus => engineerStatus;

  List<Map<String, dynamic>> get aServiceDetails => [];
}
