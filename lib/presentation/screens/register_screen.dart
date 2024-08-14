import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:proyecto_modular/presentation/screens/login_screen.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
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
                  // Registrar el usuario sin iniciar sesión automáticamente
                  final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  final User? user = userCredential.user;
                  if (user != null) {
                    // Guardar la información del usuario en la base de datos
                    await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
                      'name': nameController.text,
                      'email': emailController.text,
                      'createdAt': FieldValue.serverTimestamp(),
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registro exitoso. Por favor, inicia sesión.')),
                    );

                    // Redirigir a la pantalla de inicio de sesión
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  } else {
                    throw Exception('El registro falló. No se pudo autenticar el usuario.');
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
