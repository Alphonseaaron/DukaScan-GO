import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukascan_go/domain/models/order.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createOrder(Order order) async {
    await _firestore.collection('orders').add(order.toMap());
  }
}
