import 'package:flutter/material.dart';

class InventoryManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Management'),
      ),
      body: Center(
        child: Text('Add, edit, and remove products.'),
      ),
    );
  }
}
