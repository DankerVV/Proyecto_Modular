import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

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
      bool isAvailable = await NfcManager.instance.isAvailable();
      debugPrint('NFC availability checked: $isAvailable');
      // Comprobar si NFC está disponible en el dispositivo
      if (isAvailable) {
        setState(() {
          _nfcMessage = 'Esperando una tarjeta NFC...';
        });
        // Iniciar la sesión NFC y escuchar por etiquetas NFC descubiertas
        NfcManager.instance.startSession(
          onDiscovered: (NfcTag tag) async {
            // Procesar la etiqueta NFC
            debugPrint('NFC Tag Detected: ${tag.data}');
            setState(() {
              _nfcMessage = 'Etiqueta NFC detectada: ${tag.data}';
            });
            // Detener la sesión NFC después de la detección
            await NfcManager.instance.stopSession();
          },
          onError: (error) async {
            debugPrint('NFC Session Error: $error');
            setState(() {
              _nfcMessage = 'Error en la sesión NFC: $error';
            });
            await NfcManager.instance.stopSession(errorMessage: error.toString());
          },
        );
      } else {
        setState(() {
          _nfcMessage = 'NFC no está disponible en este dispositivo.';
        });
        debugPrint('NFC not available.');
      }
    } catch (e) {
      setState(() {
        _nfcMessage = 'Error leyendo NFC: $e';
      });
      debugPrint('Error reading NFC: $e');
    }
  }
}
