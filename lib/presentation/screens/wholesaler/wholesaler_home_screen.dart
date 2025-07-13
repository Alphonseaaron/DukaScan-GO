import 'package:flutter/material.dart';

import 'package:dukascan_go/presentation/screens/wholesaler/orders/wholesaler_order_screen.dart';
import 'package:dukascan_go/presentation/screens/wholesaler/products/wholesaler_product_screen.dart';
import 'package:flutter/material.dart';

class WholesalerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wholesaler Dashboard'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('My Products'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WholesalerProductScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('My Orders'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WholesalerOrderScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
