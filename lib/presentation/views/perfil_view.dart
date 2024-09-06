import 'dart:io';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart' as uio;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:proyecto_modular/presentation/screens/login_screen.dart';
import 'package:proyecto_modular/presentation/views/perfil_views/view_card.dart';
import 'package:proyecto_modular/presentation/views/perfil_views/profile_settings.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  _PerfilViewState createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadProfileImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      //Obtener el usuario actual de la base de datos 
      final docSnapshot = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          if (mounted) {
            setState(() {
              _imageUrl = data['profileImageUrl'];
            });
          }
        }
      }
    }
  }

  Future<void> _uploadImage(File imageFile, User user) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('profile_pictures/${user.uid}');
      await storageRef.putFile(imageFile);
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance.collection('Users').doc(user.uid).update({
        'profileImageUrl': imageUrl,
      });

      if (mounted) {
        setState(() {
          _imageUrl = imageUrl;
          print('Nueva URL de la imagen: $_imageUrl');
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Imagen guardada exitosamente.')),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar la imagen: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _selectAndUploadImage(BuildContext context, User user) async {
    final picker = ImagePicker();
    XFile? pickedFile;

    if (uio.Platform.isAndroid || uio.Platform.isIOS) {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } else if (uio.Platform.isWindows || uio.Platform.isLinux || uio.Platform.isMacOS) {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      await _uploadImage(imageFile, user);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('No se encontró ningún usuario logueado'));
    }

    return SafeArea(
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').doc(user.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar los datos: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No se encontraron datos'));
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;
          var name = data['name'] ?? 'Nombre no disponible';
          var tipo = data['tipo'] ?? 'Tipo no disponible';
          _imageUrl = data['profileImageUrl'] ?? _imageUrl;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _selectAndUploadImage(context, user),
                child: ProfileCard(
                  imagePath: _imageUrl, 
                  name: name,
                  description: tipo, 
                ),
              ),
              const SizedBox(height: 40),
              Cardinfo(context),
              const SizedBox(height: 40),
              Settingsbutton(context),
              const SizedBox(height: 40),
              Logoutbutton(context),
            ],
          );
        },
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String? imagePath;
  final String name;
  final String description;

  const ProfileCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              backgroundImage: imagePath != null && imagePath!.isNotEmpty
                  ? NetworkImage(imagePath!) //Foto de perfil 
                  : null, // La imagen predeterminada se quitó
              child: imagePath == null || imagePath!.isEmpty
                  ? const Icon(Icons.person, size: 60) 
                  : null,
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

Widget Cardinfo(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const Cardview()),
      );
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
    ),
    child: const Row(
      children: [
        SizedBox(width: 15),
        Text('Ver tarjetas', textAlign: TextAlign.left, style: TextStyle(fontSize: 22)),
        SizedBox(width: 130),
        Icon(Icons.credit_card, size: 30),
      ],
    ),
  );
}

Widget Settingsbutton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ProfileSettings()),
      );
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
    ),
    child: const Row(
      children: [
        SizedBox(width: 15),
        Text('Configurar Perfil', textAlign: TextAlign.left, style: TextStyle(fontSize: 22)),
        SizedBox(width: 130),
        Icon(Icons.settings, size: 30),
      ],
    ),
  );
}

Widget Logoutbutton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      _showAlertDialog(context);
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
    ),
    child: const Row(
      children: [
        SizedBox(width: 15),
        Text('Cerrar sesión', textAlign: TextAlign.left, style: TextStyle(fontSize: 22)),
        SizedBox(width: 130),
        Icon(Icons.logout, size: 30),
      ],
    ),
  );
}

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('Estás saliendo de la cuenta.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // No salir de la cuenta
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop(); // Cierra el diálogo
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginScreen()), // Redirige a la pantalla de inicio de sesión
              );
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}