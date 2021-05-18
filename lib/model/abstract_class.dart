import 'package:eagle_pixels/model/check_list_model.dart';

abstract class AServiceItem {
  String? get aImage;
  String? get aName;
  String? get aCctvID;
  String? get aPurchaseDate;
  String? get aCustomerName;
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
}

abstract class AJobDetail {
  String? get aCameraImage;
  String? get aCameraName;
  String? get aCameraID;

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
