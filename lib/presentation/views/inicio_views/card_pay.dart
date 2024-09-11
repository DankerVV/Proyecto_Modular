import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

class CardPay extends StatefulWidget {
  final String cardType;
  const CardPay({super.key, required this.cardType});

  @override
  State<CardPay> createState() => _CardPayState();
}

class _CardPayState extends State<CardPay> {
  String nfcMessage = 'Acerca tu dispositivo a la terminal';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startNFCFinder(widget.cardType, context);
    });
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pago"),
      ),
      body: Center(
        child: Text(
          nfcMessage,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void startNFCFinder(String cardType, BuildContext context) async {
    bool isAvailable = await NfcManager.instance.isAvailable();
      if (isAvailable) {
        NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
          var mifareClassic = MifareClassic.from(tag);
          if (mifareClassic != null) {
            try {
              // Convertir la clave a Uint8List
              Uint8List key = Uint8List.fromList([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]);
              // Autenticar el sector 1 con la clave A
              await mifareClassic.authenticateSectorWithKeyA(
                sectorIndex: 1,
                key: key,
              );
              // Intentar leer el bloque 4, que está en el sector 1
              List<int> blockData = await mifareClassic.readBlock(blockIndex: 4);
              String data = String.fromCharCodes(blockData);
              String numericData = data.replaceAll(RegExp(r'[^0-9.]'), '');
              double content = double.parse(numericData);
              if(content == 1.234){// Este es el valor de la tarjeta que será la terminal
                changeMessage('Terminal detectada');
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
                  pasajePayment();
                }
              }
            } catch (e) {
              changeMessage('Error al buscar la terminal: $e');
            }
          }
          await NfcManager.instance.stopSession();
        });
      } else {
        changeMessage('Esta función no está disponible en tu dispositivo.');
      }
  }

  void changeMessage(String frase){
    setState(() {
        nfcMessage = frase;
      });
  }
}


void processPayment (double precio){}

void pasajePayment(){}
