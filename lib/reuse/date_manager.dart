import 'package:intl/intl.dart';

class AppDateFormat {
  static const String yyyy_MM_dd = "yyyy-MM-dd";
  static const String defaultF = "yyyy-MM-dd HH:mm:ss";
  static const String registerationFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS";
  static const String ddStMMMMYYYY = "dd MMMM yyyy";
  static const String hhmmssa = "hh : mm : ss a";
  static const String attendanceDate = "hh : mm : ss a MMM yyyy";
  static const String scheduledTime = "hh.mm a MMM dd  yyyy";

  // static const String registerationFor = "yyyy-MM-dd HH:mm:ss.SSSSSS";
}

extension AppDateTime on DateTime {
  String string(String format) {
    return DateFormat(format).format(this);
  }

  String get changeDay {
    return DateFormat(AppDateFormat.yyyy_MM_dd).format(this);
  }
}
