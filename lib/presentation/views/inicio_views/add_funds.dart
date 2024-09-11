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
