import 'package:flutter/material.dart';

class ReloadPhysicalCard extends StatelessWidget {
  const ReloadPhysicalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recargar una tarjeta Física"),
      ),
      body: const Center(
        child: Text(
          'Mantén tu tarjeta MiPasaje cerca del celular',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

void nfcReader(BuildContext context){}