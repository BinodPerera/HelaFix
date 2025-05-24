import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helafix_mobile_app/models/category_sub.dart';
import 'package:helafix_mobile_app/models/service.dart';
import 'package:helafix_mobile_app/models/category.dart';
import 'package:helafix_mobile_app/models/service_provider.dart';

class ServiceService {
  final _serviceCollection = FirebaseFirestore.instance.collection('services');
  final _categoryCollection = FirebaseFirestore.instance.collection('categories');
  final _providerCollection = FirebaseFirestore.instance.collection('service_providers');
  final _subCategoryCollection = FirebaseFirestore.instance.collection('sub_categories'); // Optional if needed

  Future<void> insertService(Service service) async {
    await _serviceCollection.add({
      'name': service.name,
      'description': service.description,
      'image_base64': service.imageBase64,
      'category_id': service.categoryId,
      'sub_category_id': service.subCategoryId,
      'provider_id': service.providerId,
    });
  }

  Future<List<Service>> getAllServices() async {
    final snapshot = await _serviceCollection.get();
    return snapshot.docs.map((doc) => Service.fromMap(doc.data(), doc.id)).toList();
  }

  Future<void> deleteService(String id) async {
    await _serviceCollection.doc(id).delete();
  }

  Future<void> updateService(Service service) async {
    if (service.id == null) return;
    await _serviceCollection.doc(service.id!).update({
      'name': service.name,
      'description': service.description,
      'image_base64': service.imageBase64,
      'category_id': service.categoryId,
      'sub_category_id': service.subCategoryId,
      'provider_id': service.providerId,
    });
  }

  // ✅ Add these two new methods

  Future<List<Category>> getCategories() async {
    final snapshot = await _categoryCollection.get();
    return snapshot.docs.map((doc) => Category.fromMap(doc.data(), doc.id)).toList();
  }

  Future<List<ServiceProvider>> getServiceProviders() async {
    final snapshot = await _providerCollection.get();
    return snapshot.docs.map((doc) => ServiceProvider.fromMap(doc.data(), doc.id)).toList();
  }

  // Optional if you're using sub-categories
  Future<List<SubCategory>> getSubCategories(String categoryId) async {
    final snapshot = await _subCategoryCollection
        .where('category_id', isEqualTo: categoryId)
        .get();
    return snapshot.docs.map((doc) => SubCategory.fromMap(doc.data(), doc.id)).toList();
  }
}
