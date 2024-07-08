import 'package:flutter/material.dart';

class AppTheme{
  //final int selectedColor;
  
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: const Color.fromARGB(255, 48, 131, 51),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: const Color.fromARGB(255, 26, 123, 30),
  );
}