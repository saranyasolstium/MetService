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
