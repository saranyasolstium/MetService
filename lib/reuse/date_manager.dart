import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class AppDateFormat {
  static const String yyyy_MM_dd = "yyyy-MM-dd";
}

extension AppDateTime on DateTime {
  String string(String format) {
    return Jiffy(this).format(format);
  }
}
