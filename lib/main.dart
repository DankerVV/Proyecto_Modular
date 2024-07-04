import 'package:flutter/material.dart';
import 'package:proyecto_modular/config/theme/app_theme.dart';
import 'package:proyecto_modular/config/theme/theme_provider.dart';
import 'package:proyecto_modular/presentation/screens/main_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp(),)
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);
    return MaterialApp(
      title: 'Flutter Modular',
      debugShowCheckedModeBanner: false,
      //theme: AppTheme(selectedColor: 0).theme(), 
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeState.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      home: const MainScreen(),
    );
  }
}
