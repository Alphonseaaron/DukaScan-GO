import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant/domain/models/response/images_products_response.dart';
import 'package:restaurant/domain/models/response/products_top_home_response.dart';
import 'package:restaurant/domain/models/response/response_default.dart';
import 'package:restaurant/presentation/helpers/de_bouncer.dart';

class ProductsServices {
  final debouncer = DeBouncer(duration: Duration(milliseconds: 800));
  final StreamController<List<Productsdb>> _streamController =
      StreamController<List<Productsdb>>.broadcast();
  Stream<List<Productsdb>> get searchProducts => _streamController.stream;

  void dispose() {
    _streamController.close();
  }

  Future<ResponseDefault> addNewProduct(String name, String description,
      String price, List<XFile> images, String category) async {
    // Implement with Firebase Storage
    return ResponseDefault(resp: false, msg: 'Not implemented');
  }

  Stream<List<Productsdb>> getProductsTopHomeStream() {
    return FirebaseFirestore.instance
        .collection('products')
        .orderBy('nameProduct')
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Productsdb.fromJson(doc.data()))
            .toList());
  }

  Future<List<ImageProductdb>> getImagesProducts(String id) async {
    // Implement with Firebase Storage
    return [];
  }

  void searchProductsForName(String productName) async {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final response = await FirebaseFirestore.instance
          .collection('products')
          .where('nameProduct', isGreaterThanOrEqualTo: productName)
          .get();
      final listProduct = response.docs
          .map((doc) => Productsdb.fromJson(doc.data()))
          .toList();
      _streamController.add(listProduct);
    };
    final timer =
        Timer(Duration(milliseconds: 200), () => debouncer.value = productName);
    Future.delayed(Duration(milliseconds: 400)).then((_) => timer.cancel());
  }

  Future<List<Productsdb>> searchPorductsForCategory(String idCategory) async {
    final resp = await FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: idCategory)
        .get();
    return resp.docs.map((doc) => Productsdb.fromJson(doc.data())).toList();
  }

  Future<List<Productsdb>> listProductsAdmin() async {
    final resp = await FirebaseFirestore.instance.collection('products').get();
    return resp.docs.map((doc) => Productsdb.fromJson(doc.data())).toList();
  }

  Future<ResponseDefault> updateStatusProduct(
      String idProduct, String status) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(idProduct)
        .update({'status': status});
    return ResponseDefault(resp: true, msg: 'Product status updated');
  }

  Future<ResponseDefault> deleteProduct(String idProduct) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(idProduct)
        .delete();
    return ResponseDefault(resp: true, msg: 'Product deleted');
  }
}

final productServices = ProductsServices();