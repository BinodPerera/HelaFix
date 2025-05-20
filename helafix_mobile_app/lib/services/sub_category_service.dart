import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helafix_mobile_app/models/sub_category.dart';

class SubCategoryService {
  static final collection = FirebaseFirestore.instance.collection('sub_categories');

  // Add
  Future<void> addSubCategory(SubCategory subCategory) async {
    await collection.add({
      'name': subCategory.name,
      'category_id': subCategory.categoryId
    });
  }
}
