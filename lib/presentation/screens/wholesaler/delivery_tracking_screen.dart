import 'package:flutter/material.dart';

class DeliveryTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Tracking'),
      ),
      body: Center(
        child: Text('Track your deliveries here.'),
      ),
    );
  }
}
