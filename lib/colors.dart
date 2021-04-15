import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension Colour on Colors {
  static Color get appBlue {
    return HexColor.fromHex('#28ABE3');
  }

  static Color get appBlack {
    return HexColor.fromHex('#333333');
  }

  static Color get appDarkGrey {
    return HexColor.fromHex('#9A9A9A');
  }

  static Color get appLightGrey {
    return HexColor.fromHex('#F7F7F7');
  }

  static Color get appText {
    return HexColor.fromHex('#333333');
  }
}
