import 'package:eagle_pixels/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';

class MCheckListItem {
  String id;
  String title;
  Color color;
  MCheckListItem(
      {required this.id, required this.title, required this.color});
}

abstract class ACheckList {
  String? id;
  MCheckListItem? selectedItem;

  List<MCheckListItem>? options;
  String? title;
  String? remarks;
}

class MCheckList implements ACheckList, Codable {
  List<MCheckListItem>? options;
  MCheckListItem? selectedItem;

  String? status;

  Codable fromJson(Map<String, dynamic> map) {
    var model = MCheckList();
    return model;
  }

  bool get isValid => true;

  toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  String? remarks;

  @override
  String? title;

  @override
  String? id;
}

class JobCheckListController extends GetxController {
  var checkList = <ACheckList>[].obs;
  List<ACheckList> get selectedList {
    return checkList.where((item) => item.selectedItem != null).toList();
  }

  List<MCheckList> sampleData() {
    var models = <MCheckList>[];
    for (int i = 0; i <= 10; i++) {
      var model = MCheckList();
      model.options = [];

      model.options!
          .add(MCheckListItem(id: '1', title: "Fixed", color: Colour.appBlue));
      model.options!.add(
          MCheckListItem(id: '2', title: "Non Fixable", color: Colour.appRed));
      models.add(model);
    }
    return models;
  }

  @override
  void onInit() {
    checkList.value = sampleData();
    // ever(checkList, some());
    super.onInit();
  }

  // some() {
  //   print('model updated');
  //   Future.delayed(Duration(seconds: 10), () {
  //     checkList.value = sampleData();
  //   });
  // }
}
