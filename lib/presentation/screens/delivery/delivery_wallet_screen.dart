import 'package:flutter/material.dart';

class DeliveryWalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Balance',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '\$100.00', // TODO: Replace with actual balance
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement deposit functionality
              },
              child: Text('Deposit Funds'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Transaction History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // TODO: Replace with actual transaction count
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.arrow_downward, color: Colors.red),
                    title: Text('Delivery Fee'),
                    subtitle: Text('Order #12345'),
                    trailing: Text('-\$10.00'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
