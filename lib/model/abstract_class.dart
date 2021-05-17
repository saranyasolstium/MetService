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
