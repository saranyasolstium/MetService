import 'dart:io';
import 'dart:typed_data';

import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

// class MCheckListResponse implements Codable {
//   String? status;
//   // String? name;
//   String? message;
//   late List<MCheckList> data;
//   MCheckListResponse.init() {
//     data = [];
//   }

//   fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     final object = json['data'];
//     data = <MCheckList>[];
//     if (object != null) {
//       data.add(MCheckList.fromJson(object));
//       // name = object['name'];
//       // if (object['list'] != null) {
//       //   object['list'].forEach((v) {
//       //     data?.add(MCheckList.fromJson(object));
//       //   });
//       // }
//     }

//     return this;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data.isNotEmpty) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }

//   @override
//   bool get isValid => (data.length) > 0;
// }

class MCheckListResponse implements Codable {
  String? status;
  String? message;
  late List<MCheckList> data; // Change this to a list

  MCheckListResponse.init() {
    data = [];
  }

  fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    final object = json['data'];

    if (object != null && object is List<dynamic>) { // Check if object is a List
      data = object.map((item) => MCheckList.fromJson(item)).toList(); // Convert List items to MCheckList
    }

    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  bool get isValid => data.isNotEmpty;
}

class MCheckList {
  String? name;
  List<MCheckListItem>? list;
  List<MCheckListItem> get selectedItems {
    if (list == null) {
      return [];
    }
    return list!.where((element) => element.selectedItem != null).toList();
  }

  bool get isValid {
    return (list?.length ?? 0) > 0;
  }

  MCheckList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    list = [];
    if (json['list'] != null) {
      json['list'].forEach((v) {
        list!.add(MCheckListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['list'] = this.list?.map((v) => v.toJson()).toList();
    return data;
  }
}

class MCheckListItem implements ACheckListItem {
  int? itemID;
  String? name;
  int? type;
  int? noteRequired;
  List<MCheckListOption>? options;
  List<dynamic>? selectedOption;
  // List<dynamic>? attachedImages;
  String remarks = '';

  MCheckListItem();

  MCheckListItem.fromJson(Map<String, dynamic> json) {
    selectedImages = [];
    options = [];
    selectedOption = [];
    // attachedImages = [];
    itemID = json['id'];
    name = json['name'];
    type = json['type'];
    remarks = json['note'] ?? '';
    noteRequired = json['note_required'];
    selectedOption = json['selected_options'] ?? [];
    selectedImages = json['attached_images'] ?? [];
    if (json['options'] != null) {
      var opts = json['options'] ?? [];
      var colors = [
        Colour.appBlue,
        Colour.appRed,
        Colors.yellow,
        Colors.green,
        Colors.orange,
      ];

      if (opts is List<dynamic>) {
        for (var i = 0; i < (opts.length); i++) {
          var strValue = opts[i];
          final value = MCheckListOption(strValue, colors[i % 5]);
          options!.add(value);
          if (selectedOption!.contains(value.name)) {
            selectedItem.add(value);
          }
        }
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['note_required'] = this.noteRequired;
    data['options'] = this.options;
    data['selected_options'] = this.selectedOption;
    // data['attached_images'] = this.attachedImages;
    return data;
  }

  String get id {
    return itemID.toString();
  }

  List<MCheckListOption> selectedItem = [];

  String get title {
    return name ?? '';
  }

  String get optionType {
    return type.toString();
  }

  late List<dynamic> selectedImages;

  MCheckListOption? get lastItem {
    if (selectedItem.length > 0) {
      return selectedItem.last;
    } else {
      return null;
    }
  }
}

class MCheckListOption {
  late String id;
  final String name;
  final Color color;
  MCheckListOption(this.name, this.color) {
    id = this.name;
  }
}

