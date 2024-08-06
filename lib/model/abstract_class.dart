import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:eagle_pixels/model/check_list_model.dart';

abstract class AServiceItem {
  String? get aProductImage;
  String? get aCustomerImage;
  String? get aProdouctName;
  String? get aCctvID;
  String? get aPurchaseDate;
  String? get aCustomerName;
  String? get aRequestNo;
  String? get aStartDay;
  String? get aEndDay;
  double? get aLat;
  double? get aLong;
  String? get aSiteID;
  String? get aServiceID;
  String? get aCombinedAddress;
  String? get aEmail;
  String? get aPhoneNo;
  String? get aServiceName;
  String? get aSubServiceName;
  String? get aEmployeeName;
  double? get aLatIn;
  double? get aLatOut;
}

abstract class AShowAttendance {
  String? get aImage;
  String? get aProductName;
  String? get aCctvID;
  String? get aServiceReqNo;
  String? get aCustomerName;
  String? get aCustomerImage;
  String? get aStartDay;
  String? get aEndDay;
}

abstract class AAttendanceStatus {
  DateTime? startedDate;
}

abstract class ACheckListItem {
  String get id;
  late List<MCheckListOption> selectedItem;
  MCheckListOption? get lastItem;

  List<MCheckListOption>? options;
  String get title;
  String get optionType;
  late String remarks;
  late List<dynamic> selectedImages;
}

abstract class AJobDetail {
  //Service id
  String? get aServiceId;

  String? get aCameraImage;
  String? get aCameraName;
  String? get aCameraID;

  //Ticket Information
  String? get aTicketID;
  String? get aPriority;
  String? get aStatus;
  String? get aSource;
  String? get aSubject;
  String? get aDescription;

  //Customer Information
  String? get aCustomerName;
  String? get aCustomerImage;
  String? get aEmail;
  String? get aPhoneNo;
  String? get aServiceName;
  String? get aSubServiceName;
  // String? get aItem;
  // String? get aSerialNumber;
  // String? get aSite;
  // String? get aSiteID;
  // String? get aSubSite;
  // String? get aSaleOrder;
  // String? get aSiteMapLat;
  // String? get aSiteMapLang;

  // Service Information
  String? get aTypeOfService;
  String? get aServiceAmount;
  String? get aService;
  String? get aFloorPlan;
  String? get aFloorPlanName;
  String? get aCombinedAddress;
  String? get aAttention;
  String? get aCustomerType;
  String? get aServiceOrderNo;

  // Booking Information
  String? get aTeamName;
  String? get aBookingAmount;
  String? get aBookingDate;
  String? get aBookingTime;
  int? get aEnginnerStatus;

  String? get aServiceCover;
  String? get aTreatmentMethod;
  String? get aServiceFrequency;
  String? get aDegreeInfestation;
  String? get aBusinessSource;

  String? get aPreparation;
  String? get aBillingType;
  String? get aReferralName;
  String? get aDecisionMaker;
  String? get aEstimationFirstService;
  String? get aServicePremiseAddress;
  String? get aSeeOnSite;

  List<ACheckListItem> get checkList;
}

abstract class AActiveService extends AServiceItem {
  List<AJobTime>? aAttendanceEntry;
  String? aAddress;
}

abstract class AJobTime {
  String? aStartTime;
  String? aEndTime;
  String? aEmployeeName;
}

abstract class ADropDown {
  String get aId;
  String get aName;
  String get aEmail;
  String get aPhoneNo;
  String get aBillingAddress;
}

abstract class AProduct {
  String? get aName;
  String? get aImage;
  String? get aSerialNumber;
  String? get aWarrantyDate;
  String? get aLocation;
  String? get aSubLocation;
  String? get aFloorPlan;
  String? get aFloorPlanName;
}
