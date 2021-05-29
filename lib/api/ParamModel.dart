import 'dart:convert';

import 'package:eagle_pixels/model/abstract_class.dart';
import 'dart:io';

class ParamStartJob {
  var service_id, lat, long;
  ParamStartJob(this.service_id, this.lat, this.long);

  Map<String, dynamic> toJson() {
    return {'service_id': service_id, 'latitude': lat, 'longitude': long};
  }
}

class ParamCompleteJob {
  // ignore: non_constant_identifier_names
  var service_id, rating, signature, feedback;
  ParamCompleteJob(this.service_id, this.rating, this.signature, this.feedback);

  Map<String, dynamic> toJson() {
    return {
      'service_id': service_id,
      'rating': rating,
      'signature': signature,
      'feedback': feedback
    };
  }
}

class ParamSubmitJob {
  // ignore: non_constant_identifier_names
  var service_id, rating, signature, feedback, lat, long;
  // ignore: non_constant_identifier_names
  List<ACheckListItem> check_list;
  // ignore: non_constant_identifier_names
  ParamSubmitJob(
      {this.service_id,
      this.rating,
      this.signature,
      this.feedback,
      // ignore: non_constant_identifier_names
      this.lat,
      this.long,
      required this.check_list});

  Future<List<String>> fileToBase64(List<File> files) async {
    List<String> base64Images = [];

    for (var i in files) {
      var base64Image = base64Encode(File(i.path).readAsBytesSync());
      base64Images.add(base64Image);
    }
    return base64Images;
  }

  Future<Map<String, dynamic>> toJson() async {
    Map<String, dynamic> json = {};
    json['service_id'] = service_id;
    json['rating'] = rating;
    json['signature'] = signature;
    json['feedback'] = feedback;
    json['latitude'] = lat;
    json['longitude'] = long;
    List<ParamSubmitItem> paramCheckList = [];

    for (var i in check_list) {
      var base64Images = await fileToBase64(i.selectedImages);
      ParamSubmitItem paramSubmitItem =
          ParamSubmitItem(i.remarks, i.selectedItem!.name, base64Images);

      paramCheckList.add(paramSubmitItem);
    }
    json['check_list'] = paramCheckList.map((e) => e.toJson());

    return json;
  }
}

class ParamSubmitItem {
  // ignore: non_constant_identifier_names
  var remarks, selected_value;
  // ignore: non_constant_identifier_names
  List<String> attached_images;
  ParamSubmitItem(this.remarks, this.selected_value, this.attached_images);
  Map<String, dynamic> toJson() {
    return {
      'remarks': remarks,
      'selected_value': selected_value,
      'attached_images': attached_images,
    };
  }
}

// "selfie": "img",
// "check_list": [
//
// "remarks": "sample text",
// "selected_value": "selected_value",
// "attached_images": []
