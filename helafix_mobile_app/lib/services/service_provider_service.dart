import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service_provider.dart';

class ServiceProviderService {
  static final _collection = FirebaseFirestore.instance.collection('service_providers');

  static Stream<List<ServiceProvider>> getServiceProviders() {
    return _collection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ServiceProvider.fromMap(doc.data())).toList());
  }

  static Stream<Map<String, ServiceProvider>> getServiceProvidersWithIds() {
    return _collection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      final map = <String, ServiceProvider>{};
      for (var doc in snapshot.docs) {
        map[doc.id] = ServiceProvider.fromMap(doc.data());
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
