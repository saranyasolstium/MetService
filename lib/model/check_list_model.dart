import 'dart:io';

import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class MCheckListResponse implements Codable {
  String? status;
  // String? name;
  String? message;
  late List<MCheckList> data;
  MCheckListResponse.init() {
    data = [];
  }

  fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    final object = json['data'];
    data = <MCheckList>[];
    if (object != null) {
      data.add(MCheckList.fromJson(object));
      // name = object['name'];
      // if (object['list'] != null) {
      //   object['list'].forEach((v) {
      //     data?.add(MCheckList.fromJson(object));
      //   });
      // }
    }

    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data.isNotEmpty) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  bool get isValid => (data.length) > 0;
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
  MCheckListItem();

  MCheckListItem.fromJson(Map<String, dynamic> json) {
    selectedImages = [];
    options = [];
    itemID = json['id'];
    name = json['name'];
    type = json['type'];
    noteRequired = json['note_required'];
    if (json['options'] != null) {
      var opts = json['options'] ?? [];
      // for (var i = 0; i < 20; i++) {
      //   opts.add('Some $i ${Iterable.generate(i, (index) {
      //     return '$i';
      //   }).toString()}');
      // }
      // if (opts is List<String>) {
      // 1,2,3,4,5,6,7,8,9,10
      // 1,2,3,4,5,1,2,3,4,5

      var colors = [
        Colour.appBlue,
        Colour.appRed,
        Colors.yellow,
        Colors.green,
        Colors.orange,
      ];
      // options = [];

      if (opts is List<dynamic>) {
        for (var i = 0; i < (opts.length); i++) {
          var strValue = opts[i];
          options!.add(MCheckListOption(strValue, colors[i % 5]));
          // options!.add(MCheckListOption('some1', Colors.blue));
          // options!.add(MCheckListOption('some2', Colors.yellow));
        }
      }
    }

    // options!.add(MCheckListOption('some1', Colors.red));
    // options!.add(MCheckListOption('some2', Colors.red));
    // options!.add(MCheckListOption('some3', Colors.red));
    // options = (opts.map((e) => MCheckListOption(e, Colors.red)).toList());
    // print('some');
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['note_required'] = this.noteRequired;
    data['options'] = this.options;
    return data;
  }

  String get id {
    return itemID.toString();
  }

  String remarks = '';

  MCheckListOption? selectedItem;

  String get title {
    return name ?? '';
  }

  late List<File> selectedImages;
}

class MCheckListOption {
  late String id;
  final String name;
  final Color color;
  MCheckListOption(this.name, this.color) {
    id = this.name;
  }
}

// import 'dart:io';
//
// import 'package:eagle_pixels/api/api_service.dart';
// import 'package:eagle_pixels/model/abstract_class.dart';
// import 'package:flutter/material.dart';
//
// import '../colors.dart';
//
// class MCheckListResponse implements Codable {
//   String? status;
//   String? message;
//   List<MCheckList>? data;
//
//   fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <MCheckList>[];
//       json['data'].forEach((v) {
//         data?.add(MCheckList.fromJson(v));
//       });
//     }
//     return this;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data?.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
//
//   @override
//   bool get isValid => (data?.length ?? 0) > 0;
// }
//
// class MCheckList {
//   String? name;
//   List<MCheckListItem>? list;
//   List<MCheckListItem> get selectedItems {
//     if (list == null) {
//       return [];
//     }
//     return list!.where((element) => element.selectedItem != null).toList();
//   }
//
//   bool get isValid {
//     return (list?.length ?? 0) > 0;
//   }
//
//   MCheckList.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     if (json['list'] != null) {
//       list = <MCheckListItem>[];
//       json['list'].forEach((v) {
//         list?.add(MCheckListItem.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['list'] = this.list?.map((v) => v.toJson()).toList();
//     return data;
//   }
// }
//
// class MCheckListItem implements ACheckListItem {
//   int? itemID;
//   String? name;
//   int? type;
//   int? noteRequired;
//   List<MCheckListOption>? options;
//
//   MCheckListItem.fromJson(Map<String, dynamic> json) {
//     selectedImages = [];
//     itemID = json['id'];
//     name = json['name'];
//     type = json['type'];
//     noteRequired = json['note_required'];
//     if (json['options'] != null) {
//       var opts = json['options'] ?? [];
//       // for (var i = 0; i < 20; i++) {
//       //   opts.add('Some $i ${Iterable.generate(i, (index) {
//       //     return '$i';
//       //   }).toString()}');
//       // }
//       // if (opts is List<String>) {
//       // 1,2,3,4,5,6,7,8,9,10
//       // 1,2,3,4,5,1,2,3,4,5
//
//       var colors = [
//         Colour.appBlue,
//         Colour.appRed,
//         Colors.yellow,
//         Colors.green,
//         Colors.orange,
//       ];
//       options = [];
//
//       for (var i = 0; i < (opts.length ?? 0); i++) {
//         var strValue = opts[i];
//         options!.add(MCheckListOption(strValue, colors[i % 5]));
//         // options!.add(MCheckListOption('some1', Colors.blue));
//         // options!.add(MCheckListOption('some2', Colors.yellow));
//       }
//     }
//
//     // options!.add(MCheckListOption('some1', Colors.red));
//     // options!.add(MCheckListOption('some2', Colors.red));
//     // options!.add(MCheckListOption('some3', Colors.red));
//     // options = (opts.map((e) => MCheckListOption(e, Colors.red)).toList());
//     // print('some');
//     // }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['type'] = this.type;
//     data['note_required'] = this.noteRequired;
//     data['options'] = this.options;
//     return data;
//   }
//
//   String get id {
//     return itemID.toString();
//   }
//
//   String remarks = '';
//
//   MCheckListOption? selectedItem;
//
//   String get title {
//     return name ?? '';
//   }
//
//   late List<File> selectedImages;
// }
//
// class MCheckListOption {
//   late String id;
//   final String name;
//   final Color color;
//   MCheckListOption(this.name, this.color) {
//     id = this.name;
//   }
// }
