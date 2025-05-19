import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helafix_mobile_app/models/category.dart';

class CategoryService {
  static final _collection = FirebaseFirestore.instance.collection('categories');

  Future<void> insertCategory({ required Category category }) async {
    await _collection.add({
      'name': category.name
    });
  }

  static Stream<Map<String, Category>> getCategoriesWithIds() {
    return _collection
        .orderBy('name', descending: false)
        .snapshots()
        .map((snapshot) {
      final map = <String, Category>{};
      for (var doc in snapshot.docs) {
        map[doc.id] = Category.fromMap(doc.data());
      }
      return map;
    });
  }

  static Future<void> deleteServiceProvider(String docId) async {
    await _collection.doc(docId).delete();
  }

  static Future<void> updateServiceProvider(String docId, Map<String, dynamic> data) async {
    await _collection.doc(docId).update(data);
  }
}