import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:proyecto_modular/config/theme/app_theme.dart';
import 'package:proyecto_modular/config/theme/theme_provider.dart';
import 'package:proyecto_modular/presentation/screens/main_screen.dart';
import 'package:proyecto_modular/presentation/screens/login_screen.dart';
import 'package:proyecto_modular/presentation/screens/auth_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//const googlemapsApi = "AIzaSyDRoFD0XhW_tli0D2w0hidiAHics-V2mec";

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
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends HookConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return const MainScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
