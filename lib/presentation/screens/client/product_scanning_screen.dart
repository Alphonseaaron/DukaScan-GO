import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dukascan_go/domain/bloc/blocs.dart';
import 'package:dukascan_go/domain/models/product.dart';
import 'package:dukascan_go/domain/models/product_cart.dart';
import 'package:dukascan_go/domain/services/products_services.dart';

class ProductScanningScreen extends StatefulWidget {
  final String storeId;

  const ProductScanningScreen({required this.storeId});

  @override
  _ProductScanningScreenState createState() => _ProductScanningScreenState();
}

class _ProductScanningScreenState extends State<ProductScanningScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  final ProductsService _productsService = ProductsService();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Product'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Scan a product\'s barcode'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      try {
        final Product product = await _productsService.getProductByBarcode(scanData.code!, widget.storeId);
        final productCart = ProductCart(
          id: int.parse(product.id),
          name: product.name,
          price: product.price,
          image: product.image,
          quantity: 1,
        );
        cartBloc.add(AddProductToCartEvent(productCart));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product not found'),
            backgroundColor: Colors.red,
          ),
        );
        controller.resumeCamera();
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
