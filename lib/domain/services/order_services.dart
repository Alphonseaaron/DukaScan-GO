import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukascan_go/domain/models/order.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createOrder(Order order) async {
    await _firestore.collection('orders').add(order.toMap());
  }

  Future<List<Order>> getOrdersByWholesaler() async {
    final user = _auth.currentUser;
    if (user == null) {
      return [];
    }
    final snapshot = await _firestore
        .collection('orders')
        .where('wholesalerId', isEqualTo: user.uid)
        .get();
    return snapshot.docs.map((doc) => Order.fromMap(doc.data())).toList();
  }

  Future<List<Order>> getAvailableOrders() async {
    final snapshot = await _firestore
        .collection('orders')
        .where('status', isEqualTo: 'pending')
        .get();
    return snapshot.docs.map((doc) => Order.fromMap(doc.data())).toList();
  }
}
