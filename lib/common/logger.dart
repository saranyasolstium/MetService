import 'package:colorize/colorize.dart';

class Logger {
  static log(String specifier, String identifier) {
    color('* $specifier -> $identifier',
        isBold: true, front: Styles.YELLOW, back: Styles.YELLOW);
  }
}
