import 'package:flutter/material.dart';
import 'package:dukascan_go/presentation/screens/delivery/list_orders_delivery_screen.dart';
import 'package:dukascan_go/presentation/screens/delivery/agent_onboarding_screen.dart';
import 'package:dukascan_go/presentation/screens/delivery/delivery_wallet_screen.dart';

class DeliveryHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Dashboard'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Available Gigs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListOrdersDeliveryScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('My Wallet'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeliveryWalletScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Become a Delivery Agent'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AgentOnboardingScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}