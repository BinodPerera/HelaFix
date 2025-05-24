import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helafix_mobile_app/models/user.dart' as app_model;

class UserService {

  final _collection = FirebaseFirestore.instance.collection('users');

  Future<app_model.User?> getUserById(String id) async {
    try {
      final doc = await _collection.doc(id).get();
      if (doc.exists) {
        return app_model.User.fromMap(doc.data()!, doc.id);
      }
      return null;
    }
    catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

}