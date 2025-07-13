import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant/domain/models/response/category_all_response.dart';
import 'package:restaurant/domain/models/response/response_default.dart';

class CategoryServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ResponseDefault> addNewCategory(
      String nameCategory, String descriptionCategory) async {
    await _firestore.collection('categories').add({
      'category': nameCategory,
      'description': descriptionCategory,
    });
    return ResponseDefault(resp: true, msg: 'Category added successfully');
  }

  Stream<List<Category>> getAllCategoriesStream() {
    return _firestore.collection('categories').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Category.fromJson(doc.data())).toList());
  }

  Future<ResponseDefault> deleteCategory(String uidCategory) async {
    await _firestore.collection('categories').doc(uidCategory).delete();
    return ResponseDefault(resp: true, msg: 'Category deleted successfully');
  }
}

final categoryServices = CategoryServices();