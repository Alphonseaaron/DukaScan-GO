import 'package:flutter/material.dart';
import 'package:dukascan_go/domain/models/order.dart';
import 'package:dukascan_go/presentation/screens/delivery/delivery_tracking_screen.dart';

class OrderDetailsDeliveryScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsDeliveryScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text('Total: \$${order.total}'),
            SizedBox(height: 16.0),
            Text('Status: ${order.status}'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeliveryTrackingScreen(),
                  ),
                );
              },
              child: Text('Track Delivery'),
            ),
          ],
        ),
      ),
    );
  }
}

