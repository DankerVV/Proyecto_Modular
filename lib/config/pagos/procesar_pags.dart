import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

void initStripe() {
  //Esta es la llave publica de la cuenta de stripe de Carlos
  Stripe.publishableKey = 'pk_test_51PfRu7GDEfzc7X68gl6ZT8sf0NCtnxMwRfBvfp6j9A3NjXStNYfQIlRX4swDIh4GSOz9MVeuc87oHEJcw1NvOZ3Y00s8l1gJ8t';
}

Future<bool> procesarPago(double amount, GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey) async {
  try {
    final clientSecret = await _createPaymentIntent(amount);// Llamar al intent de pago
    await Stripe.instance.initPaymentSheet(// Inicia el PaymentSheet de Stripe
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Nombre',
      ),
    );

    await Stripe.instance.presentPaymentSheet();// Presenta el PaymentSheet
    scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(content: Text('Pago realizado con éxito')),
    );
    return true;
  } catch (e) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
    return false;
  }
}

// Función para crear el PaymentIntent
Future<String> _createPaymentIntent(double amount) async {
  final url = Uri.parse(
    'http://192.168.1.74:5001/create-payment-intent'); // Usar para android físico
  //  'http://10.0.2.2:5001/create-payment-intent');// Usar para emulador android
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
