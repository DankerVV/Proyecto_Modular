import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

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
    bool isAvailable = await NfcManager.instance.isAvailable();

    if (isAvailable) {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        var mifareClassic = MifareClassic.from(tag);
        if (mifareClassic != null) {
          try {
             // Intentar leer el bloque 4, que está en el sector 1
            List<int> blockData = await mifareClassic.readBlock(blockIndex: 4);
            String data = String.fromCharCodes(blockData); 
            setState(() {
              _nfcMessage = 'Valor leído: $data';
            });
          } catch (e) {
            setState(() {
              _nfcMessage = 'Error al leer la tarjeta: $e';
            });
          }
        }
        else {
          setState(() {
            _nfcMessage = 'No se pudo reconocer la tarjeta Mifare Classic.';
          });
        }
        
        await NfcManager.instance.stopSession();
      });
    } else {
      setState(() {
        _nfcMessage = 'NFC no está disponible en este dispositivo.';
      });
    }
  }
}
