import 'dart:ui';

import 'package:flutter/material.dart';

class ScibbleColor {
  static const Color onlineBlue = Color(0xff0D5474);
  static const Color onlineBlueDisabled = Color(0x880D5474);
  static const Color onlineOrange = Color(0xffF9B759);

  static MaterialColor get onlineBlueM => createMaterialColor(onlineBlue);
}

/// Source: https://blog.usejournal.com/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3
MaterialColor createMaterialColor(Color color) {
  final List<double> strengths = [.05];
  final swatch = <int, Color>{};
  final int r = color.red;
  final int g = color.green;
  final int b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}