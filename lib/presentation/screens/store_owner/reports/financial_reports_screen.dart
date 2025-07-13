import 'package:flutter/material.dart';

class FinancialReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financial Reports'),
      ),
      body: Center(
        child: Text('Generate and view financial reports.'),
      ),
    );
  }
}
