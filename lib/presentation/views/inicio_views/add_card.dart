import 'dart:async';

import 'package:flutter/material.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecciona una opción \n BORRAR -> contraseña: 1234"),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 50,),
          ListTile(
            title: const Text('Mi Pasaje verde', style: TextStyle(fontSize: 20),),
            onTap: () async {
              bool isPasswordCorrect = await verifyPassword(context);
              if (isPasswordCorrect) {
                // Vista: crear una nueva tarjeta
              }
            },
          ),
          ListTile(
            title: const Text('Mi Pasaje amarillo', style: TextStyle(fontSize: 20),),
            onTap: () async {
              bool isPasswordCorrect = await verifyPassword(context);
              if (isPasswordCorrect) {
                // Vista: crear una nueva tarjeta
              }
            },
          ),
          ListTile(
            title: const Text('Supervisor', style: TextStyle(fontSize: 20),),
            onTap: () async {
              bool isPasswordCorrect = await verifyPassword(context);
              if (isPasswordCorrect) {
                // Vista: crear una nueva tarjeta
              }
            },
          ),
        ],
      ),
    );
  }
}

Future<bool> verifyPassword(BuildContext context) {
  final Completer<bool> completer = Completer<bool>();
  final passwordController = TextEditingController();
  const password = '1234';  

  showDialog(
    context: context,
    barrierDismissible: true, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Ingrese la contraseña'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const Text('Este es un trámite gubernamental, sólo personal autorizado puede continuar.'),
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
                completer.complete(true); // Contraseña correcta
                Navigator.of(context).pop(); // Cierra el diálogo
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
              //completer.complete(false); // Usuario canceló el diálogo
              Navigator.of(context).pop(); // Cierra el diálogo
            },
            child: const Text('Cancelar'),
          ),
        ],
      );
    },
  );
  return completer.future; // Devuelve el Future<bool>
}