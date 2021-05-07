import 'package:flutter/material.dart';

String safeString(dynamic value, {String def = "NA"}) {
  String stringValue = value.toString();
  if (stringValue != null && stringValue.length > 0) {
    return stringValue;
  } else {
    return def;
  }
}
