import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_modular/presentation/views/perfil_views/profile_settings.dart';
import 'package:proyecto_modular/presentation/views/perfil_views/view_card.dart';
import 'package:proyecto_modular/presentation/screens/login_screen.dart';

class PerfilView extends StatelessWidget {
  const PerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('Users').doc('jDexl7M7gYPkpvoNJK1o').snapshots(),
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

              return Center(
                child: ProfileCard(
                  imagePath: 'profile_test.jpg', // Asegúrate de tener esta imagen en tu carpeta assets
                  name: name,
                  description: 'Estudiante',
                ),
              );
            },
          ),
          const SizedBox(height: 40,),
          Cardinfo(context),

          const SizedBox(height: 40,),
          Settingsbutton(context),

          const SizedBox(height: 40,),
          Logoutbutton(context),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String imagePath;  
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
              backgroundImage: AssetImage(imagePath),
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
            onPressed: () {
              Navigator.of(context).pop(); // Salir de la cuenta
               Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
