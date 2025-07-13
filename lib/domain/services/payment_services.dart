import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  Future<void> makePayment(double amount, String currency) async {
    try {
      final paymentIntent = await _createPaymentIntent(amount, currency);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: 'DukaScanGo',
        ),
      );
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>?> _createPaymentIntent(
      double amount, String currency) async {
    try {
      final response = await http.post(
        Uri.parse('your_cloud_function_url'), // TODO: Replace with your Cloud Function URL
        body: json.encode({
          'amount': (amount * 100).toInt(),
          'currency': currency,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      return json.decode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
