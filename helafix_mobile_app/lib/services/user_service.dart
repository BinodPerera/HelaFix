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
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }
  
  Future<bool> userUpdate({ required  app_model.User updated_user, required String userId}) async {
    try {
      await _collection.doc(userId).update({
        'name': updated_user.name,
        'email': updated_user.email,
        'phone': updated_user.phone,
        'image_base64': updated_user.image_base64,
      });

      print("User updated successfully.");
      return true;
    } catch (e) {
      print("Error updating user: $e");
      return false;
    }
  }
}
