import 'package:flutter/material.dart';

import 'package:dukascan_go/presentation/screens/store_owner/inventory/inventory_management_screen.dart';
import 'package:dukascan_go/presentation/screens/store_owner/orders/order_management_screen.dart';
import 'package:dukascan_go/presentation/screens/store_owner/reports/financial_reports_screen.dart';
import 'package:flutter/material.dart';

class StoreOwnerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store Owner Dashboard'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Inventory Management'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InventoryManagementScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Order Management'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderManagementScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Financial Reports'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FinancialReportsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
