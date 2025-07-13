import 'package:flutter/material.dart';
import 'package:dukascan_go/domain/models/product.dart';
import 'package:dukascan_go/domain/services/products_service.dart';
import 'package:dukascan_go/presentation/screens/store_owner/inventory/add_product_screen.dart';

class WholesalerProductScreen extends StatefulWidget {
  @override
  _WholesalerProductScreenState createState() =>
      _WholesalerProductScreenState();
}

class _WholesalerProductScreenState extends State<WholesalerProductScreen> {
  final ProductsService _productsService = ProductsService();
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _productsService.listProductsAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wholesaler Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProductScreen(),
                ),
              ).then((_) {
                setState(() {
                  _productsFuture = _productsService.listProductsAdmin();
                });
              });
            },
          ),
        ],
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
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _productsService.deleteProduct(product.id.toString()).then((_) {
                      setState(() {
                        _productsFuture = _productsService.listProductsAdmin();
                      });
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
