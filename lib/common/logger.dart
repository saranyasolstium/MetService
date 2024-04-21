import 'package:colorize/colorize.dart';
import 'package:eagle_pixels/model/attendece_status_model.dart';

class Logger {
  Logger(String s, MAttendanceStatusResponse? status);

  static log(String specifier, String identifier) {
    color('* $specifier -> $identifier',
        isBold: true, front: Styles.YELLOW, back: Styles.YELLOW);
  }
}
