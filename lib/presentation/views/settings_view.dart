import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proyecto_modular/config/theme/theme_provider.dart';

class SettingsView extends HookConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
          darkMode(ref),
        ],
      ),
    );
  }
}

Widget darkMode (WidgetRef ref){
  final appThemeState = ref.watch(appThemeStateNotifier);
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(width: 20),
      const Text('Modo Oscuro', style: TextStyle(fontSize: 20),),
      const SizedBox(width: 10),
      Switch(
    value: appThemeState.isDarkModeEnabled,
    onChanged: (enabled) {
      if (enabled) {
        appThemeState.setDarkTheme();
      } else {
        appThemeState.setLightTheme();
      }
    },
  ),
    ],
  );
}