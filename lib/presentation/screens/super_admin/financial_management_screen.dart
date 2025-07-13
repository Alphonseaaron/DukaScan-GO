import 'package:flutter/material.dart';

class FinancialManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financial Management'),
      ),
      body: Center(
        child: Text('Manage finances here.'),
      ),
    );
  }
}
