import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
//import 'package:nfc_manager/nfc_manager.dart';


class ReloadPhysicalCard extends StatefulWidget {
  const ReloadPhysicalCard({super.key});

  @override
  State<ReloadPhysicalCard> createState() => _ReloadPhysicalCardState();
}

class _ReloadPhysicalCardState extends State<ReloadPhysicalCard> {
  String _nfcMessage = 'Mantén tu tarjeta MiPasaje cerca del celular';

  @override
  void initState() {
    super.initState();
    startNFCReading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recargar una tarjeta Física"),
      ),
      body: Center(
        child: Text(
          _nfcMessage,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void startNFCReading() async {
    try {
      // Inicia la sesión NFC
      NFCTag tag = await FlutterNfcKit.poll();
      // Procesa la etiqueta NFC
      setState(() {
        _nfcMessage = 'Tarjeta NFC detectada: ${tag.type}';
      });
    } catch (e) {
      setState(() {
        _nfcMessage = 'Error al leer NFC: $e';
      });
    } finally {
      // Detén la sesión NFC después de la lectura
      await FlutterNfcKit.finish();
    }
  }
}
