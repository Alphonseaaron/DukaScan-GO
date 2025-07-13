import 'package:flutter/material.dart';

class PaymentManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Management'),
      ),
      body: Center(
        child: Text('Manage your payments here.'),
      ),
    );
  }
}
