import 'package:eagle_pixels/colors.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/dynamic_font.dart';

const kCameraPlaceholder = 'images/camera.png';
const kUserPlaceholder = 'images/user.png';
const kErrorMsg = 'something went wrong please try again';

String safeString(dynamic value, {String def = "NA"}) {
  if (value == null) {
    return def;
  } else {
    String stringValue = value.toString();
    if (stringValue.length > 0) {
      return stringValue;
    } else {
      return def;
    }
  }
}

Widget titleText(String title) => Text(
      title,
      style: TextStyle(
          color: Colour.appBlack,
          fontWeight: FontWeight.w400,
          fontSize: 16.dynamic),
    );

enum ViewState { loading, updating, refreshing, failed, success }

extension ViewStateExtension on ViewState {
  bool get isSuccess {
    return this == ViewState.success;
  }

  bool get isLoading {
    return this == ViewState.loading;
  }

  bool get isFailed {
    return this == ViewState.failed;
  }
}

String constructAddress(List<String?> units) {
  var address = '';
  units.forEach((element) {
    if (element != null && element != '') {
      address += '$element, ';
    }
  });
  if (address.length < 2) {
    return '';
  } else {
    return address.substring(0, address.length - 2);
  }
}
