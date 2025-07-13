import 'package:flutter/material.dart';

import 'package:dukascan_go/domain/models/product.dart';
import 'package:dukascan_go/domain/services/store_services.dart';
import 'package:dukascan_go/presentation/screens/client/product_scanning_screen.dart';
import 'package:flutter/material.dart';

class StoreHomeScreen extends StatefulWidget {
  final String? storeId;

  const StoreHomeScreen({required this.storeId});

  @override
  _StoreHomeScreenState createState() => _StoreHomeScreenState();
}

class _StoreHomeScreenState extends State<StoreHomeScreen> {
  final StoreService _storeService = StoreService();
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _storeService.getProducts(widget.storeId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store ${widget.storeId}'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: Image.network(product.image),
                title: Text(product.name),
                subtitle: Text('\$${product.price}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScanningScreen(),
            ),
          );
        },
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
