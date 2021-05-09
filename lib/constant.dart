import 'package:eagle_pixels/colors.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/dynamic_font.dart';

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
