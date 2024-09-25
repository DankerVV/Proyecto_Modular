import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; 
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proyecto_modular/presentation/screens/login_screen.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    io.File? _profileImage;
    String? _webImageFileName;
    Uint8List? _webImageBytes;

    Future<void> _selectAndUploadImage() async {
      if (kIsWeb) {
        //Esta sección es para testear desde un sitio web
        final picker = ImagePicker();
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          _webImageBytes = await pickedFile.readAsBytes();
          _webImageFileName = pickedFile.name;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se seleccionó ninguna imagen')),
          );
        }
      } else if (io.Platform.isAndroid || io.Platform.isIOS) {
        //Esta sección es para solicitar la imagen desde la galeria del celular 
        var status = await Permission.photos.request();
        if (status.isGranted) {
          final picker = ImagePicker();
          final pickedFile = await picker.pickImage(source: ImageSource.gallery);
          
          if (pickedFile != null) {
            _profileImage = io.File(pickedFile.path);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No se seleccionó ninguna imagen')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Permiso de galería denegado')),
          );
        }
      }
    }

    Future<void> _registerUser() async {
      try {
        final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        final User? user = userCredential.user;
        if (user != null) {
          String? imageUrl;

          if (kIsWeb && _webImageBytes != null) {
            //Subir imagen a Firebase Storage desde la web, solo para testear 
            final storageRef = FirebaseStorage.instance.ref().child('profile_pictures/${user.uid}');
            final uploadTask = storageRef.putData(_webImageBytes!, SettableMetadata(contentType: 'image/jpeg'));
            final snapshot = await uploadTask;
            imageUrl = await snapshot.ref.getDownloadURL();
          } else if (_profileImage != null) {
            //Subir imagen a Firebase Storage desde celular 
            final storageRef = FirebaseStorage.instance.ref().child('profile_pictures/${user.uid}');
            await storageRef.putFile(_profileImage!);
            imageUrl = await storageRef.getDownloadURL();
          }

          //Guardarmos la información del usuario en la base de datos
          await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
            'name': nameController.text,
            'email': emailController.text,
            'profileImageUrl': imageUrl ?? '', 
            'tipo': 'Pasajero', 
            'saldo': 0.0,
            'createdAt': FieldValue.serverTimestamp(),
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registro exitoso. Por favor, inicia sesión.')),
          );

          //Redirigir a la pantalla de inicio de sesión
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
    }

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
              onPressed: _selectAndUploadImage,
              child: const Text('Seleccionar Imagen de Perfil'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerUser,
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}