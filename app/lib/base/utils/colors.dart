import 'package:flutter/material.dart';

abstract class AppColors {
  // some base colors
  static const transparent = Colors.transparent;
  static const white = Colors.white;
  static const black = Colors.black;
  static const green = Color(0xff3CA455);
  static const gray = Colors.grey;
  static const red = Color.fromRGBO(232, 58, 67, 1);
  static var bottomsheetBarrierColor = Colors.black.withOpacity(0.5);

  static var color848484 = const Color(0xff848484);
  static var colorD1D1D1 = const Color(0xffD1D1D1);
  static var snackbarErrorBackground = const Color(0xffFFE1E1);
  static var borderColor = const Color(0xffF0F0F0);

  // app specifc colors.. there are usually 3 different sets of colors in app

  static const primary = Color.fromRGBO(78, 161, 239, 1);
  static const primaryDark = Color.fromRGBO(25, 121, 212, 1);
  static const primaryLight = Color.fromRGBO(102, 173, 239, 1);

  static const secondary = Color.fromRGBO(254, 207, 223, 1);
  static const secondaryDarkLight = Color.fromRGBO(242, 149, 180, 1);
  static const secondaryLight = Color.fromRGBO(233, 206, 215, 1);

  static const tertiary = Color.fromRGBO(215, 222, 233, 1);
  static const tertiaryDarkLight = Color.fromRGBO(215, 222, 233, 1);
  static const tertiaryLight = Color.fromRGBO(215, 222, 233, 1);

  static const primaryElementColor = Color(0xff3F3A34);
  static const secondaryElementColor = Color(0xff9B948A);
  static const tertiaryElementColor = Color(0xffEAE5D8);

  static const formDefault = Color.fromRGBO(38, 71, 144, 0.1);
  static const formTap = Color.fromRGBO(38, 71, 144, 0.1);

  static const background = Color(0xffF6F5F2);
}

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
