import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukascan_go/domain/models/store.dart';
import 'package:dukascan_go/domain/models/product.dart';

class StoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Store>> getStores() async {
    final snapshot = await _firestore.collection('stores').get();
    return snapshot.docs.map((doc) => Store.fromFirestore(doc)).toList();
  }

  Future<List<Product>> getProducts(String storeId) async {
    final snapshot = await _firestore
        .collection('stores')
        .doc(storeId)
        .collection('products')
        .get();
    return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
  }
}
