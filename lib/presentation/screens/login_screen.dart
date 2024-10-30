import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proyecto_modular/presentation/screens/auth_service.dart';
import 'package:proyecto_modular/presentation/screens/register_screen.dart';
import 'package:proyecto_modular/presentation/screens/main_screen.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final authService = ref.watch(authServiceProvider);

    // Función para navegar a una nueva pantalla sin necesidad de context aquí
    void navigateTo(Widget screen) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => screen),
      );
    }

    // Función para mostrar un SnackBar sin depender directamente del context
    void showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Correo'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Inicia sesión con las credenciales proporcionadas
                  await authService.signIn(
                    emailController.text,
                    passwordController.text,
                  );

                  // Redirige a la pantalla principal si el inicio de sesión es exitoso
                  navigateTo(const MainScreen());
                } catch (e) {
                  // Muestra el mensaje de error
                  showError(e.toString());
                }
              },
              child: const Text('Ingresar'),
            ),
            TextButton(
              onPressed: () {
                // Redirige a la pantalla de registro
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                );
              },
              child: const Text('¿No tienes una cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}