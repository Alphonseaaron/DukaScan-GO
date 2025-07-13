import 'package:flutter/material.dart';

class OnlineShoppingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Shopping'),
      ),
      body: Center(
        child: Text('Browse and search the store\'s product catalog.'),
      ),
    );
  }
}
