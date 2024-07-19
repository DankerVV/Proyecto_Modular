import 'package:flutter/material.dart';
//import 'package:nfc_manager/nfc_manager.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class CardPay extends StatefulWidget {
  const CardPay({super.key});

  @override
  State<CardPay> createState() => _CardPayState();
}

class _CardPayState extends State<CardPay> {
  final String ejemplo = 'hola';
  @override
  void initState() {
    super.initState();
    startNFCFinder(ejemplo);
  }

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

void startNFCFinder(String cardType) async {
  //TODO: se recibe un string con el tipo de dato
  if (cardType == 'basico'){
    //TODO: pagar 9.50
  }
  else if(cardType == 'estudiante'){
    //TODO: restar -1 pasaje
  }
  else if(cardType == 'amarillo'){
    //TODO: pagar 4.75
  }
  else if(cardType == 'supervisor'){
    //TODO: pagar nada, solo desbloquear
  }
}