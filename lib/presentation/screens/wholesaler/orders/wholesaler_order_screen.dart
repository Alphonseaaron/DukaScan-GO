import 'package:flutter/material.dart';
import 'package:dukascan_go/domain/models/order.dart';
import 'package:dukascan_go/domain/services/order_services.dart';

class WholesalerOrderScreen extends StatefulWidget {
  @override
  _WholesalerOrderScreenState createState() => _WholesalerOrderScreenState();
}

class _WholesalerOrderScreenState extends State<WholesalerOrderScreen> {
  final OrderService _orderService = OrderService();
  late Future<List<Order>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _orderService.getOrdersByWholesaler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wholesaler Orders'),
      ),
      body: FutureBuilder<List<Order>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return ListTile(
                title: Text('Order #${order.id}'),
                subtitle: Text('Total: \$${order.total}'),
              );
            },
          );
        },
      ),
    );
  }
}
