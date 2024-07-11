import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class CardPay extends StatefulWidget {
  const CardPay({super.key});

  @override
  State<CardPay> createState() => _CardPayState();
}

class _CardPayState extends State<CardPay> {
  @override
  void initState() {
    super.initState();
    startNFCReading();
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

void startNFCReading() async {
  try {
    bool isAvailable = await NfcManager.instance.isAvailable();
    //We first check if NFC is available on the device.
    if (isAvailable) {
    //If NFC is available, start an NFC session and listen for NFC tags to be discovered.
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        // Process NFC tag, When an NFC tag is discovered, print its data to the console.
        debugPrint('NFC Tag Detected: ${tag.data}');
        print('NFC Tag Detected: ${tag.data}');
      },
    );
    } else {
      debugPrint('NFC not available.');
      print('NFC not available.');
    }
  } catch (e) {
    debugPrint('Error reading NFC: $e');
    print('Error reading NFC: $e');
  }
}