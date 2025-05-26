import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helafix_mobile_app/models/category_sub.dart';

class SubCategoryService {
  static final collection = FirebaseFirestore.instance.collection('sub_categories');

  // Add
  Future<void> addSubCategory(SubCategory subCategory) async {
    await collection.add({
      'name': subCategory.name,
      'category_id': subCategory.categoryId
    });
  }

  // static Stream<List<SubCategory>> getSubCategoriesByParent(String categoryId) {
  //   return FirebaseFirestore.instance
  //       .collection('sub_categories')
  //       .where('category_id', isEqualTo: categoryId)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //           .map((doc) => SubCategory.fromMap(doc.data()))
  //           .toList());
  // }

  static Stream<Map<String, SubCategory>> getSubCategoriesByParent(String categoryId) {
    return collection
        .where('category_id', isEqualTo: categoryId)
        .snapshots()
        .map((snapshot) {
      final map = <String, SubCategory>{};
      for (var doc in snapshot.docs) {
        map[doc.id] = SubCategory.fromMap(doc.data(), doc.id); // ✅ pass doc.id
      }
      return map;
    });
  }
}
