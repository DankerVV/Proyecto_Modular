import 'package:flutter/material.dart';

class ViewBalance extends StatelessWidget {
  const ViewBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ver saldo aqui\ndesde la base de datos'),
        //TODO: Tomar el valor del saldo de la tarjeta en la base de datos
        ) 
    );
  }
}