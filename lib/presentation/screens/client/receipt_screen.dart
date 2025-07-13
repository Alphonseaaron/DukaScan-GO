import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiptScreen extends StatelessWidget {
  final String orderId;

  const ReceiptScreen({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Order ID: $orderId'),
            SizedBox(height: 20),
            QrImage(
              data: orderId,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}
