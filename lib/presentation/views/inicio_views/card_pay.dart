import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

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
  void dispose() {
    // Detén la sesión NFC cuando se sale de la pantalla actual
    NfcManager.instance.stopSession();
    super.dispose();
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

void startNFCFinder(String cardType, BuildContext context) async{
  try{
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        print('Tag NFC detectado: $tag');
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

        await NfcManager.instance.stopSession();
      },
      onError: (e){
        // Maneja cualquier error que ocurra durante la sesión NFC
        print('Error en la sesión NFC: $e');
        NfcManager.instance.stopSession();
        throw Exception('Error al manejar el NFC: $e');
       },
    );
  }
  catch(e){
    print('Error general: $e');
    // Detén la sesión NFC en caso de error
    await NfcManager.instance.stopSession();
  }
}

void processPayment (double precio){}

void pasajePayment(){}
