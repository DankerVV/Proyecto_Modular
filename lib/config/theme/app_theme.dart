import 'package:flutter/material.dart';

const List<Color> _colorThemes=[
  Color.fromARGB(255, 26, 123, 30),
  Colors.yellow,
  Colors.red,
  Colors.blue,
  Colors.orange,
  Colors.pink
];

class AppTheme{
  final int selectedColor;
AppTheme({  this.selectedColor=0}): assert (selectedColor >= 0 && selectedColor <= _colorThemes.length-1,
'Colors must be between 0 and ${_colorThemes.length-1}');

  ThemeData theme(){
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor],
      
    );
  }
}