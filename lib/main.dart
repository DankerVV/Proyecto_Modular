import 'package:flutter/material.dart';
import 'package:proyecto_modular/config/theme/app_theme.dart';
import 'package:proyecto_modular/presentation/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Modular',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0).theme(),
      home: const MainScreen(),
    );
  }
}
