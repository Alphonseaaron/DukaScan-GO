import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukascan_go/domain/models/product_cart.dart';

class Order {
  final String userId;
  final List<ProductCart> products;
  final double total;
  final String type; // "click_collect" or "delivery"
  final Timestamp createdAt;

  Order({
    required this.userId,
    required this.products,
    required this.total,
    required this.type,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'products': products.map((p) => p.toMap()).toList(),
      'total': total,
      'type': type,
      'createdAt': createdAt,
    };
  }
}
