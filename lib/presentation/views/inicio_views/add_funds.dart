import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    //Esta es la llave publica de la cuenta de stripe de Carlos
    Stripe.publishableKey = 'pk_test_51PfRu7GDEfzc7X68gl6ZT8sf0NCtnxMwRfBvfp6j9A3NjXStNYfQIlRX4swDIh4GSOz9MVeuc87oHEJcw1NvOZ3Y00s8l1gJ8t';
  }

  Future<String> _createPaymentIntent(double amount) async {
    final url = Uri.parse('http://127.0.0.1:5000/create-payment-intent');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'amount': (amount * 100).toInt()}),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body['client_secret'];
    } else {
      throw Exception('Failed to create payment intent');
    }
  }

  Future<void> _processPayment(double amount) async {
    try {
      final clientSecret = await _createPaymentIntent(amount);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Nombre',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      _scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Pago realizado con éxito')),
      );
    } catch (e) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
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
                    _processPayment(amount);
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
