import 'package:flutter/material.dart';

class CardPay extends StatefulWidget {
  final String cardType;
  const CardPay({super.key, required this.cardType});//recibir un String en la variable cardType

  @override
  State<CardPay> createState() => _CardPayState();
}

class _CardPayState extends State<CardPay> {
  @override
  void initState() {
    super.initState();
    startNFCFinder(widget.cardType, context);
  }

  @override
  Widget build(BuildContext context) {
    //NOTA: USAR ESTE MISMO ARCHIVO PARA PAGAR CON CUALQUIER TARJETA, RECIBIENDO ALGÚN PARÁMETRO O ALGO
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

void startNFCFinder(String cardType, BuildContext context) async {
  //TODO: buscar una terminal NFC, y proseguir unicamente cuando se encuentre.
  if (cardType == 'basico'){
    processPayment(9.50);
  }
  else if(cardType == 'verde'){
    pasajePayment();//siempre es un solo pago
  }
  else if(cardType == 'amarillo'){
    processPayment(4.75);
  }
  else if(cardType == 'supervisor'){
    //TODO: pagar nada, solo desbloquear
  }
}

void processPayment (double precio){}

void pasajePayment(){}