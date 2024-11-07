import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proyecto_modular/main.dart';
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

                  // Si el inicio de sesión es exitoso, redirige a la pantalla de inicio
                  navigatorKey.currentState?.pushReplacement(
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                } catch (e) {
                  // Si ocurre un error, muestra un mensaje de error
                  print('ERROR TRISTE: $e');
                  scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              },
              child: const Text('Ingresar'),
            ),
            TextButton(
              onPressed: () {
                // Redirige a la pantalla de registro si el usuario no tiene una cuenta
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
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
