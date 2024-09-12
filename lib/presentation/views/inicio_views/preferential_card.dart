import 'package:flutter/material.dart';

class PreferentialCard extends StatelessWidget {
  final String cardType;

  const PreferentialCard({super.key, required this.cardType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarjeta Preferencial'), 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Aquí va la tarjeta preferencial'),
          ],
        ),
      ),
    );
  }
}
