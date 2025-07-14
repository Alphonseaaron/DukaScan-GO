import 'package:flutter/material.dart';
import 'package:dukascan_go/presentation/screens/admin/users/users_screen.dart';
import 'package:dukascan_go/presentation/screens/admin/dashboard/admin_dashboard_screen.dart';
import 'package:dukascan_go/presentation/screens/admin/financials/financials_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Dashboard'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminDashboardScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('User Management'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UsersScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Financials'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FinancialsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
