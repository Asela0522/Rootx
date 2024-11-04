import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  static const backendUrl = 'http://10.11.3.159:5000'; // Replace with your Flask server URL

  static Future<void> initiatePayment(int amount) async {
    try {
      // 1. Create a payment intent on the server
      final response = await http.post(
        Uri.parse('$backendUrl/create-payment-intent'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'amount': amount}),
      );

      final body = json.decode(response.body);

      // 2. Extract the client secret from the response
      final clientSecret = body['client_secret'];

      // 3. Confirm payment in Flutter using the client secret
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        style: ThemeMode.system,
        merchantDisplayName: 'Your Bus Service',
      ));

      // 4. Present payment sheet
      await Stripe.instance.presentPaymentSheet();

      // Show success message upon payment confirmation
      print('Payment successful!');
    } catch (e) {
      print('Payment failed: $e');
    }
  }
}
