import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_modular/presentation/screens/login_screen.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  String _name = '';
  String? _userId;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  Future<void> _getUserId() async {
    User? user = FirebaseAuth.instance.currentUser; // Obtener el usuario actual
    if (user != null) {
      _userId = user.uid;
      _loadUserData();
    } else {
      // Manejar el caso en que el usuario no esté autenticado
      print("El usuario no inicio sesión");
    }
  }

  Future<void> _loadUserData() async {
    if (_userId != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(_userId)  // UID del usuario actual
            .get();

        if (userDoc.exists) {
          setState(() {
            _name = userDoc.get('name');
          });
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  Future<void> _updateUserData() async {
    if (_userId != null) {
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(_userId)  // UID del usuario actual
            .update({
          'name': _name,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Perfil actualizado')),
        );
      } catch (e) {
        print("Error updating user data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurar perfil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Nombre'),
                readOnly: !_isEditing,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El campo de "Nombre" no puede estar vacío';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_isEditing) {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _updateUserData();
                      }
                    }
                    _isEditing = !_isEditing;
                  });
                },
                child: Text(_isEditing ? 'Guardar Cambios' : 'Editar Perfil'),
              ),
              const SizedBox(height: 40),
              Deleteaccount(context),
            ],
          ),
        ),
      ),
    );
  }
}

// Eliminar Cuenta 
Widget Deleteaccount(BuildContext context){
  return(
    ElevatedButton(
       onPressed: (){
        _showAlertDialog(context);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      ),
      child: const Row(
        children: [
          SizedBox(width: 15),
          Text('Eliminar cuenta', textAlign: TextAlign.left, style: TextStyle(fontSize: 22),),
          SizedBox(width: 70,),
        ],
      ),
    )
  );
}

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Eliminar cuenta'),
        content: const Text('Una vez borrada la cuenta esta no se podrá recuperar. ¿Estás seguro de ello?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              try {
                // Obtener el usuario actual
                User? user = FirebaseAuth.instance.currentUser;

                if (user != null) {
                  // Borrar los datos del usuario en la base de datos
                  await FirebaseFirestore.instance.collection('Users').doc(user.uid).delete();

                  // Eliminar la cuenta del usuario
                  await user.delete();

                  // ir a la pantalla de inicio de sesión
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                }
              } catch (e) {
                // Manejar errores (como la necesidad de volver a autenticarse antes de eliminar la cuenta)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al eliminar la cuenta: ${e.toString()}')),
                );
              }
            },
            child: const Text('Aceptar'),
          ),
        ],
      );
    },
  );
}
