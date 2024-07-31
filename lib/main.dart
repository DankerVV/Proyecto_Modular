import 'package:flutter/material.dart';
import 'package:proyecto_modular/config/theme/app_theme.dart';
import 'package:proyecto_modular/config/theme/theme_provider.dart';
import 'package:proyecto_modular/presentation/screens/main_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Stripe.publishableKey = "pk_test_51PfRu7GDEfzc7X68gl6ZT8sf0NCtnxMwRfBvfp6j9A3NjXStNYfQIlRX4swDIh4GSOz9MVeuc87oHEJcw1NvOZ3Y00s8l1gJ8t";
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);

    return MaterialApp(
      title: 'Flutter Modular',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeState.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      home: const MainScreen(),
    );
  }
}
