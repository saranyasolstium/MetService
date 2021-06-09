import 'dart:convert';

import 'package:eagle_pixels/model/abstract_class.dart';
import 'dart:io';

class ParamStartJob {
  var serviceID, lat, long;
  ParamStartJob(this.serviceID, this.lat, this.long);

  Map<String, dynamic> toJson() {
    return {'service_id': serviceID, 'latitude': lat, 'longitude': long};
  }
}

class ParamSubmitJob {
  var serviceID;
  List<ACheckListItem> checkList;

  ParamSubmitJob({this.serviceID, required this.checkList});

  Future<List<String>> fileToBase64(List<File> files) async {
    List<String> base64Images = [];
    for (var i in files) {
      final byte = await File(i.path).readAsBytes();
      var base64Image = base64Encode(byte);
      base64Images.add(base64Image);
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
        selectedValue: item.selectedItem!.name,
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
  var serviceID, rating, signature, feedback, lat, long;
  ParamCompleteJob({
    this.serviceID,
    this.rating,
    this.signature,
    this.feedback,
    // this.lat,
    // this.long,
  });

  Future<Map<String, dynamic>> toJson() async {
    Map<String, dynamic> json = {};
    json['service_id'] = serviceID;
    json['rating'] = rating;
    json['signature'] = signature;
    json['feedback'] = feedback;
    // json['latitude'] = lat;
    // json['longitude'] = long;
    return json;
  }
}

class ParamSubmitItem {
  var remarks, selectedValue, checkList, id;
  List<String> attachedImages;
  ParamSubmitItem(
      {this.remarks,
      this.selectedValue,
      required this.attachedImages,
      this.id,
      this.checkList});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'checklist': checkList,
      'selected_value': selectedValue,
      'remarks': remarks,
      'attached_images': [],
      // 'attached_images': attachedImages,
    };
  }
}
