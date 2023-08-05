import 'package:flutter/material.dart';

import 'config.dart';

class ThemeApp {
  static lightTheme() {
    return ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 0.0, backgroundColor: Palette.primaryColor),
        primaryColor: Palette.primaryColor,
        canvasColor: Palette.primaryColor);
  }

  static darktheme() {
    return ThemeData.dark();
  }
}
