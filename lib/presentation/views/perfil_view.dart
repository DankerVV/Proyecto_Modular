import 'dart:io';
import 'package:flutter/material.dart';
import 'package:proyecto_modular/main.dart';
import 'package:proyecto_modular/presentation/views/inicio_views/add_funds.dart';
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
  PerfilViewState createState() => PerfilViewState();
}

class PerfilViewState extends State<PerfilView> {
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getSaldo();
    });
  }
  Future<void> _getSaldo() async {
    final String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final DocumentReference userRef = FirebaseFirestore.instance.collection('Users').doc(uid);
    
    DocumentSnapshot userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      setState(() {
        saldo = userData['saldo'] ?? 0.0;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadProfileImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final docSnapshot = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
      if (docSnapshot.exists) {
        //final data = docSnapshot.data() as Map<String, dynamic>?;
        final data = docSnapshot.data();

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
        setState(() => _imageUrl = imageUrl);
      }

      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Imagen guardada exitosamente.')),
      );
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
              cardInfo(context),
              const SizedBox(height: 40),
              _buildSettingsButton(),
              const SizedBox(height: 40),
              settingsButton(context),
              const SizedBox(height: 40),
              logoutButton(context),
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

Widget cardInfo(BuildContext context) {
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
        SizedBox(width: 140),
        Icon(Icons.credit_card, size: 30),
      ],
    ),
  );
}

Widget settingsButton(BuildContext context) {
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
        Text('Configurar perfil', textAlign: TextAlign.left, style: TextStyle(fontSize: 22)),
        SizedBox(width: 95),
        Icon(Icons.settings, size: 30),
      ],
    ),
  );
}

Widget logoutButton(BuildContext context) {
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

Widget fundsButton(BuildContext context, double saldo) {
  return ElevatedButton(
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const AddFunds()),
      );
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
    ),
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 15),
        const Text('Agregar saldo', textAlign: TextAlign.left, style: TextStyle(fontSize: 22)),
        const SizedBox(width: 120),
        Expanded(child: Text('\$${saldo.toStringAsFixed(2)}', textAlign: TextAlign.left, style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic))),
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
              //Navigator.of(context).pop(); // Cierra el diálogo
              navigatorKey.currentState?.pop();
              //Navigator.of(context).pushReplacement
              navigatorKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()), // Redirige a la pantalla de inicio de sesión
                (route) => false, // Elimina todas las rutas previas
              );
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}