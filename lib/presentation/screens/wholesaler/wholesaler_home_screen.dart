import 'package:flutter/material.dart';
import 'package:dukascan_go/presentation/screens/wholesaler/products/wholesaler_product_screen.dart';
import 'package:dukascan_go/presentation/screens/wholesaler/orders/wholesaler_order_screen.dart';
import 'package:dukascan_go/presentation/screens/wholesaler/pos/wholesaler_pos_screen.dart';
import 'package:dukascan_go/presentation/screens/wholesaler/components/wholesaler_home_card.dart';

class WholesalerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wholesaler Dashboard'),
      ),
      body: ListView(
        children: [
          WholesalerHomeCard(
            title: 'POS',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WholesalerPosScreen(),
                ),
              );
            },
          ),
          WholesalerHomeCard(
            title: 'Products',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WholesalerProductScreen(),
                ),
              );
            },
          ),
          WholesalerHomeCard(
            title: 'Orders',
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
