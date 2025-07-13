import 'package:flutter/material.dart';

class StoreOwnerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store Owner Dashboard'),
      ),
      body: Center(
        child: Text('Welcome, Store Owner!'),
      ),
    );
  }
}
