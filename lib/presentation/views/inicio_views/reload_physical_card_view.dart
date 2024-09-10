import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:proyecto_modular/config/pagos/procesar_pags.dart';

class ReloadPhysicalCard extends StatefulWidget {
  const ReloadPhysicalCard({super.key});

  @override
  State<ReloadPhysicalCard> createState() => _ReloadPhysicalCardState();
}

class _ReloadPhysicalCardState extends State<ReloadPhysicalCard> {
  String _nfcMessage = 'Mantén tu tarjeta Mi Pasaje cerca del celular';
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double _saldo = -1111.11;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    
    startNFCReading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text("Recarga una Tarjeta Física"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: 
          Column(
            children: [
              const SizedBox(height: 75),
              Text(
                _nfcMessage,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 75,),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cantidad a añadir'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce una cantidad';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount < 10) {
                    return 'La cantidad debe ser al menos 10 MXN';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if(_saldo != -1111.11){// verificacion para saber si se leyó la carta
                      final amount = double.parse(_amountController.text);
                      double saldoFinal = amount + _saldo;
                      procesarPago(amount, _scaffoldMessengerKey);
                      startNFCWriting(saldoFinal);
                      //pagar(saldoFinal, amount);
                    }
                  }
                },
                child: const Text('Añadir Fondos'),
              ),
            ],
          ),
        ),
      ),
    );
  }

//   Future<void> pagar(double saldoFinal, double amount) async {
//   bool pago = await procesarPago(amount, _scaffoldMessengerKey);
//   if (pago) {
//     startNFCWriting(saldoFinal);
//   }
// }
  
  void startNFCReading() async {
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
            _saldo = double.parse(numericData);
            changeMessage('Saldo actual: $numericData');
          } catch (e) {
            changeMessage('Error al leer la tarjeta: $e');
          }
        }
        else {
          changeMessage('No se pudo reconocer la tarjeta, debe ser tipo Mifare Classic.');
        }
        await NfcManager.instance.stopSession();
      });
    } else {
      changeMessage('NFC no está disponible en este dispositivo.');
    }
  }

  void startNFCWriting (double saldoFinal) async{
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
            
            // Convertir el valor a escribir en una lista de bytes (max 16 bytes)
            String valueString = saldoFinal.toString();
            List<int> valueBytes = List<int>.from(valueString.codeUnits);
            valueBytes += List<int>.filled(16 - valueBytes.length, 0); // Rellenar con ceros si es necesario

            // Intentar escribir en el bloque 4, que está en el sector 1
            Uint8List dataToWrite = Uint8List.fromList(valueBytes);
            await mifareClassic.writeBlock(blockIndex: 4, data: dataToWrite);
            changeMessage('Saldo actualizado: $saldoFinal');
            
          } catch (e) {
            changeMessage('Error al escribir en la tarjeta: $e');
          }
        } else {
          changeMessage('No se pudo reconocer la tarjeta, debe ser tipo Mifare Classic.');
        }
        await NfcManager.instance.stopSession();
      });
    } else {
      changeMessage('NFC no está disponible en este dispositivo.');
    }
  }

  void changeMessage(String frase){
    setState(() {
        _nfcMessage = frase;
      });
  }
}
