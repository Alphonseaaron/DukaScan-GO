import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final String id;
  final String name;
  final String logo;
  final GeoPoint location;

  Store({
    required this.id,
    required this.name,
    required this.logo,
    required this.location,
  });

  factory Store.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Store(
      id: doc.id,
      name: data['name'] ?? '',
      logo: data['logo'] ?? '',
      location: data['location'] ?? GeoPoint(0, 0),
    );
  }
}
