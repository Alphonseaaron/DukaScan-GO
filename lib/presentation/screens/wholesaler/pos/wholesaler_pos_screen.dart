import 'package:flutter/material.dart';
import 'package:dukascan_go/presentation/screens/wholesaler/pos/wholesaler_pos_add_product_screen.dart';

class WholesalerPosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wholesaler POS'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WholesalerPosAddProductScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Wholesaler POS Screen'),
      ),
    );
  }
}
