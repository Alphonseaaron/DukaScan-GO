import 'package:flutter/material.dart';

class GuestAccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guest Access'),
      ),
      body: Center(
        child: Text('Browse stores and products as a guest.'),
      ),
    );
  }
}
