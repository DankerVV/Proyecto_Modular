import 'package:flutter/material.dart';

class CardPay extends StatelessWidget {
  const CardPay({super.key});

  @override
  Widget build(BuildContext context) {
    //NOTA: INTENTAR USAR ESTE MISMO ARCHIVO PARA PAGAR CON CUALQUIER TARJETA, RECIBIENDO ALGÚN PARÁMETRO O ALGO
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pago"),
      ),
      body: const Center(
        child: Text(
          'Acerca tu celular a la terminal de pago',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}