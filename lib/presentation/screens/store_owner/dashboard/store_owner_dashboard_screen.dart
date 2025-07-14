import 'package:flutter/material.dart';

class StoreOwnerDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store Owner Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            _buildDashboardCard('Total Orders', '123'),
            _buildDashboardCard('Total Sales', '\$1,234'),
            _buildDashboardCard('Low Stock Items', '5'),
            _buildDashboardCard('Pending Deliveries', '12'),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
