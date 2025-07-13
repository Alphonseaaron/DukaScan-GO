import 'package:flutter/material.dart';

class ProductCatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Catalog'),
      ),
      body: Center(
        child: Text('Manage your product catalog here.'),
      ),
    );
  }
}
