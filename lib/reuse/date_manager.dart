import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class AppDateFormat {
  static const String yyyy_MM_dd = "yyyy-MM-dd";
  static const String defaultF = "yyyy-MM-dd HH:mm:ss";
  static const String registerationFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS";
  static const String ddStMMMMYYYY = "do MMMM yyyy";
  static const String hhmmssa = "hh : mm : ss a";

  // static const String registerationFor = "yyyy-MM-dd HH:mm:ss.SSSSSS";
}

extension AppDateTime on DateTime {
  String string(String format) {
    return Jiffy(this).format(format);
  }

  String get changeDay {
    return DateFormat(AppDateFormat.yyyy_MM_dd).format(this);
  }
}
