import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor primarySwatch = MaterialColor(0xff06488B, {
    50: Color.fromRGBO(6, 72, 139, .1),
    100: Color.fromRGBO(6, 72, 139, .2),
    200: Color.fromRGBO(6, 72, 139, .3),
    300: Color.fromRGBO(6, 72, 139, .4),
    400: Color.fromRGBO(6, 72, 139, .5),
    500: Color.fromRGBO(6, 72, 139, .6),
    600: Color.fromRGBO(6, 72, 139, .7),
    700: Color.fromRGBO(6, 72, 139, .8),
    800: Color.fromRGBO(6, 72, 139, .9),
    900: Color.fromRGBO(6, 72, 139, 1.0),
  });

  static const Color whiteColor = Color(0xffffffff);
  static const Color black54 = Color(0x8A000000);
  static const Color black87 = Color(0xDD000000);
  static const Color black = Color(0xff000000);
  static const Color black_16 = Color(0x28000000);
  static const Color darkBlue_2 = Color(0xff06488B);
  static const Color textColor = Color(0xcc2e2e5d);
  static const Color roundColorNotActive = Color(0xff999999);
  static const Color roundColorActive = Color(0xff06488B);
  static const Color darkAsh = Color(0xffB8B8C7);
  static const Color water = Color(0xff55C3ED);
  static const Color yellow = Color(0xffFFC700);
  static const Color lightYellow = Color(0xffFFED3D);
  static const Color lightAsh = Color(0xff6A6A8B);
  static const Color lightPurple = Color(0xff9D7CFC);
  static const Color dashboardCardColor = Color(0xff7253C9);
  static const Color simmerDark = Color(0xB3C0C0C6);
  static const Color simmerLight = Color(0x3DC0C0C0);
  static const Color darkBlue_4 = Color(0xff2E2E5D);
  static const Color lightBlue = Color(0x1706488b);
  static const Color profileButtonColor = Color(0xff06488b);
  static const Color red = Color(0xFFEF5350);
  static const Color hintStyleTextColor = Color(0xB3C0C0C6);
  static const Color stripBorderColor = Color(0x1706488b);
  static const Color succesButonColor = Color(0xFF019722);
  static const Color transparent = Color(0x00000000);
  static const Color loginFieldColor = Color(0xffF5F5FA);
  static const Color bluishWhite = Color(0xFFF8FAFC);
  static const Color shopTextCardSplashEffect = Color(0x8893C5F1);
  static const Color profileBackgroundColor = Color(0xffF3F1FE);
  static const Color successBackground = Color(0xff00AE84);
}

class GenerateColor {
  static Color fromHex(String hexString) {
    if ((hexString).isEmpty) {
      return const Color.fromRGBO(255, 255, 255, 0);
    }
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));

    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
