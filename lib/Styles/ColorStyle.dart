import 'package:flutter/material.dart';

class ColorStyle {
  static final Color primaryColor_52BC7F = hex("#52BC7F");
  static final Color greyColor_606060 = hex("#606060");
  static final Color greyColor_0130F26 = hex("#130F26");
  static final Color redColor_0F15222 = hex("#F15222");
  static final Color greyColor_0A09F99 = hex("#A09F99");
  static final Color greyColor_0E6E6E6 = hex("#E6E6E6");
  static final Color greyColor_0E3E3E1 = hex("#E3E3E1");
  static final Color greyColor_999999 = hex("#999999");
  static final Color greyColor_082623 = hex("#082623");
  static final Color greyColor_02C2C2E = hex("#2C2C2E");
  static final Color yellowColor_0FDC530 = hex("#FDC530");
  static final Color greenColor_52BC7F = hex("#52BC7F");
  static final Color lightGreenColor_52BC7F = hex("#1A52BC7F");

  static final Color blueSkyColor_61AFF6 = hex("#61AFF6");
  static final Color blueColor_514899 = hex("#514899");
  static final Color blackColor_000000 = hex("#000000");
  static final Color pinkColor_F15222 = hex("#1AF15222");

  static Color hex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension ColorConversion on Color {
  MaterialColor toMaterialColor() {
    final List strengths = <double>[.05];
    final Map<int, Color> swatch = {};
    final r = red, g = green, b = blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(value, swatch);
  }
}
