import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dukascan_go/domain/bloc/blocs.dart';
import 'package:dukascan_go/domain/models/product_cart.dart';

class ProductScanningScreen extends StatefulWidget {
  @override
  _ProductScanningScreenState createState() => _ProductScanningScreenState();
}

class _ProductScanningScreenState extends State<ProductScanningScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  final cartBloc = CartBloc();

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
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      final product = Product(id: scanData.code!, name: "Scanned Product", price: 10.0, image: "");
      final productCart = ProductCart(
        id: int.parse(product.id),
        name: product.name,
        price: product.price,
        image: product.image,
        quantity: 1,
      );
      cartBloc.add(AddProductToCartEvent(productCart));
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
