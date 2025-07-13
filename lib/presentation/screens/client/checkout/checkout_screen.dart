import 'package:flutter/material.dart';
import 'package:dukascan_go/presentation/screens/client/checkout/payment_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukascan_go/domain/models/order.dart' as order_model;
import 'package:dukascan_go/domain/services/order_services.dart';
import 'package:dukascan_go/presentation/screens/client/checkout/order_success_screen.dart';
import 'package:dukascan_go/presentation/screens/client/checkout/payment_screen.dart';
import 'package.flutter_bloc/flutter_bloc.dart';
import 'package:dukascan_go/domain/bloc/blocs.dart';

class CheckoutScreen extends StatelessWidget {
  final OrderService _orderService = OrderService();

  void _createOrder(BuildContext context, String type) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    final order = order_model.Order(
      userId: authBloc.state.user!.uid,
      products: cartBloc.state.products!,
      total: cartBloc.state.total,
      type: type,
      createdAt: Timestamp.now(),
    );

    _orderService.createOrder(order).then((_) {
      cartBloc.add(OnClearCartEvent());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderSuccessScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Checkout Screen'),
            ElevatedButton(
              onPressed: () => _createOrder(context, 'click_collect'),
              child: Text('Click & Collect'),
            ),
            ElevatedButton(
              onPressed: () => _createOrder(context, 'delivery'),
              child: Text('Delivery'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(),
                  ),
                );
              },
              child: Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
