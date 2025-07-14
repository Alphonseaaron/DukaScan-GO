import 'package:flutter/material.dart';
import 'package:dukascan_go/presentation/screens/store_owner/inventory/inventory_management_screen.dart';
import 'package:dukascan_go/presentation/screens/store_owner/orders/order_management_screen.dart';
import 'package:dukascan_go/presentation/screens/store_owner/reports/financial_reports_screen.dart';
import 'package:dukascan_go/presentation/screens/store_owner/dashboard/store_owner_dashboard_screen.dart';
import 'package:dukascan_go/presentation/components/custom_card.dart';

class StoreOwnerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store Owner Dashboard'),
      ),
      body: ListView(
        children: [
          CustomCard(
            title: 'Dashboard',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreOwnerDashboardScreen(),
                ),
              );
            },
          ),
          CustomCard(
            title: 'Inventory Management',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InventoryManagementScreen(),
                ),
              );
            },
          ),
          CustomCard(
            title: 'Order Management',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderManagementScreen(),
                ),
              );
            },
          ),
          CustomCard(
            title: 'Financial Reports',
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
