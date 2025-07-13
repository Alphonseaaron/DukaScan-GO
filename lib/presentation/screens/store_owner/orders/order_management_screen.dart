import 'package:flutter/material.dart';

class OrderManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Management'),
      ),
      body: Center(
        child: Text('View and manage online orders.'),
      ),
    );
  }
}
