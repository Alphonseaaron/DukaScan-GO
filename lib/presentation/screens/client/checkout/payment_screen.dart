import 'package:flutter/material.dart';

import 'package:dukascan_go/domain/services/payment_services.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final PaymentService _paymentService = PaymentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _paymentService.makePayment(100.0, 'USD');
          },
          child: Text('Pay Now'),
        ),
      ),
    );
  }
}
