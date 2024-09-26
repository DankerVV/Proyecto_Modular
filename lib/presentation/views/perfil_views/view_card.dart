import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cardview extends StatelessWidget {
  const Cardview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tus tarjetas"),
      ),
      body: const Center(
        child: CardsList(),
      ),
    );
  }
}

class CardsList extends StatelessWidget {
  const CardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user?.uid ?? '';

    if (uid.isEmpty) {
      return const Center(child: Text('UID no disponible'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Cards')
          .where('uid', isEqualTo: uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar las tarjetas'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No hay tarjetas disponibles'));
        }

        return ListView(
          children: snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final cardId = doc.id;

            return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              title: Text('Tipo: ${data['tipo']}', style: const TextStyle(fontSize: 18)),
              subtitle: data['tipo'] == 'verde'
                  ? Text('Pasajes: ${data['pasajes']}', style: const TextStyle(fontSize: 16))
                  : null,
              trailing: PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == 'activar') {
                    activateCard(context, uid, cardId);
                  } else if (value == 'desactivar') {
                    deactivateCard(context, cardId);
                  } else if (value == 'borrar') {
                    deleteCard(context, cardId);
                  }
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    if (!data['activo'])
                      const PopupMenuItem<String>(
                        value: 'activar',
                        child: Text('Activar'),
                      ),
                    if (data['activo'])
                      const PopupMenuItem<String>(
                        value: 'desactivar',
                        child: Text('Desactivar'),
                      ),
                    const PopupMenuItem<String>(
                      value: 'borrar',
                      child: Text('Borrar'),
                    ),
                  ];
                },
              ),
            ),
          );
          }).toList(),
        );
      },
    );
  }

  void activateCard(BuildContext context, String uid, String selectedCardId) async {
    final batch = FirebaseFirestore.instance.batch();

    final cardsSnapshot = await FirebaseFirestore.instance
        .collection('Cards')
        .where('uid', isEqualTo: uid)
        .get();

    //Desactivar tarjetas
    for (var cardDoc in cardsSnapshot.docs) {
      if (cardDoc.id != selectedCardId) {
        batch.update(cardDoc.reference, {'activo': false});
      }
      
    }

    //Activar tarjeta
    batch.update(
      FirebaseFirestore.instance.collection('Cards').doc(selectedCardId),
      {'activo': true},
    );

    ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tarjeta activada')),
          );
    
    await batch.commit();
  }

  void deactivateCard(BuildContext context, String cardId) async {
    //Desactivar la tarjeta activa actual 
    await FirebaseFirestore.instance.collection('Cards').doc(cardId).update({'activo': false});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tarjeta desactivada')),
    );
  }

  Future<void> deleteCard(BuildContext context, String cardId) async {
    //Borrar la tarjeta seleccionada 
    bool isPasswordCorrect = await verifyPassword(context);
    if (isPasswordCorrect) {
      FirebaseFirestore.instance.collection('Cards').doc(cardId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tarjeta borrada')),
          );
    }
  }
}

Future<bool> verifyPassword(BuildContext context) {
  final Completer<bool> completer = Completer<bool>();
  final passwordController = TextEditingController();
  const password = '1234';  // Contraseña de verificación

  showDialog(
    context: context,
    barrierDismissible: true, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Ingrese código de autorización'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text('Esta acción solo puede ser realizada por el personal autorizado, favor de ingresar el código de autorización'),
              const SizedBox(height: 15,),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Contraseña',
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (passwordController.text == password) {
                completer.complete(true); 
                Navigator.of(context).pop(); 
              } else {
                const snackBar = SnackBar(
                  content: Text('Contraseña incorrecta'),
                ); 
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: const Text('Aceptar'),
          ),
          TextButton(
            onPressed: () {
              completer.complete(false); 
              Navigator.of(context).pop(); 
            },
            child: const Text('Cancelar'),
          ),
        ],
      );
    },
  );
  return completer.future; 
}
