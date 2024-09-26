import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
            if (content == 1.234) { // Valor de la tarjeta que será la terminal
              String message = '';
              changeMessage('Terminal detectada');
              if (cardType == 'basico') {
                message = await processPayment(9.50, cardType); // Restar 9.50 en el saldo
              } else if (cardType == 'verde') {
                message = await pasajePayment(cardType); // Pago por tipo de tarjeta
              } else if (cardType == 'amarillo') {
                message = await processPayment(4.75, cardType); // Restar 4.75 en el saldo
              } else if (cardType == 'supervisor') {
                message = await pasajePayment(cardType); // Supervisor no paga saldo
              }
              changeMessage(message);
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

  void changeMessage(String frase) {
    setState(() {
      nfcMessage = frase;
    });
  }
}

Future<String> processPayment(double monto, String cardType) async {
  try {
    // Obtener referencia a la tarjeta en la base de datos
    final String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final DocumentReference userRef = FirebaseFirestore.instance.collection('Users').doc(uid);
    DocumentSnapshot userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      Map<String, dynamic> cardData = userSnapshot.data() as Map<String, dynamic>;
      // Obtener el saldo actual de la tarjeta
      double saldoActual = cardData['saldo'] ?? 0.0;
      // Verificar el tipo de tarjeta y restar el monto correspondiente
      if (cardType == 'basico') {
        saldoActual -= monto;
      } else if (cardType == 'amarillo') {
        saldoActual -= monto;
      }
      // Asegurarse de no tener un saldo negativo
      if (saldoActual < 0) {
        saldoActual = 0;
      }
      // Actualizar el campo "saldo" en la base de datos
      await userRef.update({'saldo': saldoActual});
      return 'Saldo actualizado: \$${saldoActual.toStringAsFixed(2)}.'; // Retornar el mensaje
    } else {
      return 'Error con la tarjeta.';
    }
  } catch (e) {
    return 'Error con el pago: $e';
  }
}

Future<String> pasajePayment(String cardType) async {
    try {
      // Obtener el UID del usuario actual
      final String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

      // Realizar la consulta para buscar la tarjeta activa con el UID del usuario
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Cards')
          .where('uid', isEqualTo: uid) // Filtrar por UID
          .where('activo', isEqualTo: true) // Filtrar por tarjetas activas
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Procesar la tarjeta activa
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> cardData = doc.data() as Map<String, dynamic>;

          // Obtener el tipo de tarjeta, el número actual de pasajes y el estado activo
          String tipo = cardData['tipo'];
          int pasajesActuales = cardData['pasajes'] ?? 0;

          // Solo restar pasajes si es "verde" y no es "supervisor"
          if (tipo == 'verde') {
            int nuevosPasajes = pasajesActuales - 1;
            // Asegurarse de no tener un valor negativo
            if (nuevosPasajes < 0) {
              nuevosPasajes = 0;
            }
            // Actualizar el campo "pasajes" en la base de datos
            await doc.reference.update({'pasajes': nuevosPasajes});
            return('Pasajes actualizados: $nuevosPasajes.');
          } else if (tipo == 'supervisor') {
            return('Supervisor');
          }
        }
      } else {
        return('No existen tarjetas activas.');
      }
    } catch (e) {
      return('Error al procesar el pago: $e');
    }
    return 'Error desconocido';
  }