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

  Future<void> _loadProfileImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final docSnapshot = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>?;
        if (data != null && mounted) {
          setState(() {
            _imageUrl = data['profileImageUrl'];
          });
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
        setState(() => _imageUrl = imageUrl);
      }

      _showSnackBar('Imagen guardada exitosamente.');
    } catch (e) {
      _showSnackBar('Error al guardar la imagen: ${e.toString()}');
    }
  }

  Future<void> _selectAndUploadImage(User user) async {
    final picker = ImagePicker();
    XFile? pickedFile;

    if (uio.Platform.isAndroid || uio.Platform.isIOS || 
        uio.Platform.isWindows || uio.Platform.isLinux || uio.Platform.isMacOS) {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      await _uploadImage(imageFile, user);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _navigateTo(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    _navigateTo(const LoginScreen());
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
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error al cargar los datos: ${snapshot.error}'));
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
                onTap: () => _selectAndUploadImage(user),
                child: ProfileCard(
                  imagePath: _imageUrl,
                  name: name,
                  description: tipo,
                ),
              ),
              const SizedBox(height: 40),
              _buildCardInfoButton(),
              const SizedBox(height: 40),
              _buildSettingsButton(),
              const SizedBox(height: 40),
              _buildLogoutButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCardInfoButton() {
    return ElevatedButton(
      onPressed: () => _navigateTo(const Cardview()),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      ),
      child: const Row(
        children: [
          SizedBox(width: 15),
          Text('Ver tarjetas', style: TextStyle(fontSize: 22)),
          Spacer(),
          Icon(Icons.credit_card, size: 30),
        ],
      ),
    );
  }

  Widget _buildSettingsButton() {
    return ElevatedButton(
      onPressed: () => _navigateTo(const ProfileSettings()),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      ),
      child: const Row(
        children: [
          SizedBox(width: 15),
          Text('Configurar Perfil', style: TextStyle(fontSize: 22)),
          Spacer(),
          Icon(Icons.settings, size: 30),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return ElevatedButton(
      onPressed: _showLogoutDialog,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      ),
      child: const Row(
        children: [
          SizedBox(width: 15),
          Text('Cerrar sesión', style: TextStyle(fontSize: 22)),
          Spacer(),
          Icon(Icons.logout, size: 30),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar sesión'),
          content: const Text('Estás saliendo de la cuenta.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
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
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: imagePath != null && imagePath!.isNotEmpty
                  ? NetworkImage(imagePath!)
                  : null,
              child: imagePath == null || imagePath!.isEmpty
                  ? const Icon(Icons.person, size: 60)
                  : null,
            ),
            const SizedBox(height: 10),
            Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(description, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}