import 'package:flutter/material.dart';

class Cardview extends StatelessWidget {
  const Cardview ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tus tarjetas "),
      ),
      body: const Center(
        child:
         Text(
          'Aqui se verán las tarjetas',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}