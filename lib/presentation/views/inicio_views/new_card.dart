import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewCard extends StatelessWidget {
  final String cardType;

  NewCard({super.key, required this.cardType});

  @override
  Widget build(BuildContext context) {
    // Obtener el UID del usuario actual
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user?.uid ?? 'Usuario no disponible';

    String tipo;
    int pasajes;
    bool activo;

    switch (cardType) {
      case 'verde':
        tipo = 'verde';
        pasajes = 200;
        activo = false ;
        break;
      case 'amarillo':
        tipo = 'amarillo';
        pasajes = 200;
        activo = false;
        break;
      case 'supervisor':
        tipo = 'supervisor';
        pasajes = 200;
        activo = false;
        break;
      default:
        tipo = 'desconocido';
        pasajes = 0;
        activo = false;
        break;
    }

    //Agregar los datos a firebase
    _addCardToFirestore(tipo, pasajes, uid, activo);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarjeta agregada"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Se agregó una tarjeta preferencial del tipo: $tipo', textAlign: TextAlign.left, style: TextStyle(fontSize: 18)),
            const Text('Favor de ir a la sección de ver tarjetas en el perfil para activarla', textAlign: TextAlign.left, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  void _addCardToFirestore(String tipo, int pasajes, String uid, bool activo) {
    CollectionReference cards = FirebaseFirestore.instance.collection('Cards');

    cards.add({
      'tipo': tipo,
      'pasajes': pasajes,
      'uid': uid,
      'activo': false,
    });
  }
}
