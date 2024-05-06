import 'dart:convert';
import 'dart:typed_data';

import 'package:eagle_pixels/model/abstract_class.dart';

class ParamStartJob {
  var serviceID, lat, long, img;
  ParamStartJob(this.serviceID, this.lat, this.long, this.img);

  Map<String, dynamic> toJson() {
    return {
      'RequestID': serviceID,
      'latitude': lat,
      'longitude': long,
      'before_service_img': ""
    };
  }
}

class ParamSubmitJob {
  var serviceID;
  List<ACheckListItem> checkList;

  ParamSubmitJob({this.serviceID, required this.checkList});

  Future<List<String>> fileToBase64(List<dynamic> files) async {
    List<String> base64Images = [];
    for (var i in files) {
      // final byte = await File(i.path).readAsBytes();
      if (i is Uint8List) {
        var base64Image = base64Encode(i);
        base64Images.add(base64Image);
      }
    }
    return base64Images;
  }

  Future<Map<String, dynamic>> toJson() async {
    Map<String, dynamic> json = {};
    json['service_id'] = serviceID;
    List<ParamSubmitItem> paramCheckList = [];

    for (var item in checkList) {
      var base64Images = await fileToBase64(item.selectedImages);
      ParamSubmitItem paramSubmitItem = ParamSubmitItem(
        id: item.id,
        checkList: item.title,
        selectedValue: item.selectedItem.map((e) => e.name).toList(),
        remarks: item.remarks,
        attachedImages: base64Images,
      );
      paramCheckList.add(paramSubmitItem);
    }
    json['check_list'] = paramCheckList.map((e) => e.toJson()).toList();
    print(json.toString());
    return json;
  }
}

class ParamCompleteJob {
  var requestID,
      imagPath,
      signature,
      technicianSign,
      feedback,
      lat,
      long,
      technicianComment,
      paymentMode,
      chemicalList,
      visitType,
      inspectionReport,
      preparation,
      areasInspected,
      remark,
      rating;
  ParamCompleteJob({
    this.requestID,
    this.imagPath,
    this.rating,
    this.signature,
    this.feedback,
    this.technicianComment,
    this.paymentMode,
    this.technicianSign,
    this.chemicalList,
    this.visitType,
    this.inspectionReport,
    this.areasInspected,
    this.preparation,
    this.remark,
  });

  Future<Map<String, dynamic>> toJson() async {
    Map<String, dynamic> json = {};
    json['RequestID'] = requestID;
    json['employee_sign'] = technicianSign;
    json['signature'] = signature;
    json['rating'] = rating;
    json['customer_comment'] = technicianComment;
    json['employee_comment'] = feedback;
    json['paymet_mode'] = paymentMode;
    json['chemical_list'] = chemicalList;
    json['visit_type'] = visitType;
    json["inspection_report"] = inspectionReport;
    json['preparation'] = preparation;
    json['areas_inspected'] = areasInspected;
    json['after_service_img'] = imagPath;
    

    return json;
  }
}

class ParamSubmitItem {
  var remarks, checkList, id;
  List<String> attachedImages;
  List<String> selectedValue;
  ParamSubmitItem(
      {this.remarks,
      required this.selectedValue,
      required this.attachedImages,
      this.id,
      this.checkList});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'checklist': checkList,
      'selected_value': selectedValue,
      'remarks': remarks,
      // 'attached_images': [],
      'attached_images': attachedImages,
    };
  }
}

class ParamCreateJob {
  var customerID,
      productItemID,
      serviceDate,
      serviceTypeID,
      subject,
      description;

  ParamCreateJob(
      {required this.customerID,
      required this.productItemID,
      required this.serviceTypeID,
      required this.serviceDate,
      required this.subject,
      required this.description});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['customer_id'] = customerID;
    json['product_item_id'] = productItemID;
    json['service_date'] = serviceDate;
    json['service_type_id'] = serviceTypeID;
    json['subject'] = subject;
    json['description'] = description;
    return json;
  }
}
