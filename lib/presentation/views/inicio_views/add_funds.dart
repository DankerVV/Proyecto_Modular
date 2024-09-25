import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_modular/config/pagos/procesar_pags.dart';

class AddFunds extends StatefulWidget {
  const AddFunds({super.key});

  @override
  AddFundsState createState() => AddFundsState();
}

class AddFundsState extends State<AddFunds> {
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Fondos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                    final amount = double.parse(_amountController.text);
                    procesarPago(amount, _scaffoldMessengerKey); // Llamar a la función de pago
                    agregarSaldo(amount);
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
}

Future<void> agregarSaldo(double monto) async {
  try {
    // Obtener referencia al usuario en la base de datos
    final String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid); // Usar el ID del usuario

    // Obtener los datos del usuario desde Firestore
    DocumentSnapshot userSnapshot = await userRef.get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

      // Obtener el saldo actual del usuario
      double saldoActual = userData['saldo'] ?? 0.0;

      // Sumar el monto al saldo actual
      saldoActual += monto;

      // Actualizar el campo "saldo" en la base de datos
      await userRef.update({'saldo': saldoActual});

      print('El saldo ha sido actualizado a $saldoActual.');
    } else {
      print('El usuario no existe.');
    }
  } catch (e) {
    print('Error al agregar fondos: $e');
  }
}
