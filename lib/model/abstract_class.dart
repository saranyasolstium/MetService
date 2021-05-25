import 'dart:io';

import 'package:eagle_pixels/model/check_list_model.dart';

abstract class AServiceItem {
  String? get aImage;
  String? get aName;
  String? get aCctvID;
  String? get aPurchaseDate;
  String? get aCustomerName;
  String? get aRequestNo;
  String? get aStartDay;
  String? get aEndDay;
  String? get aServiceType;
}

abstract class AAttendanceStatus {
  DateTime? startedDate;
}

abstract class ACheckListItem {
  String get id;
  MCheckListOption? selectedItem;
  List<MCheckListOption>? options;
  String get title;
  late String remarks;
  late List<File> selectedImages;
}

abstract class AJobDetail {
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
  String? get aItem;
  String? get aSerialNumber;
  String? get aSite;
  String? get aSubSite;
  String? get aSaleOrder;

  String? get aPurchaseDate;
  String? get aPurchaseOrderNumber;
  String? get aScheduleDate;
  String? get aCustomerName;
  String? get aScheduleTime;
  String? get aScheduledBy;
  String? get aWarrantyStatus;
  String? get aWarrantyEndingOn;
  String? get aCustomerInstruction;

  String? get aStartTime;
  String? get aEndTime;
  String? get aWarrantyCard;
  List<ACheckListItem> get checkList;
}
