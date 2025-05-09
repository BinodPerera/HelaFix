import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'created_at': FieldValue.serverTimestamp(),
      });

      return null;
    } catch (e) {
      return 'Registration failed. ${e.toString()}';
    }
  }

  Future<String> updateUserLocation({
    required double latitude,
    required double longitude,
  }) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await _firestore.collection('users').doc(uid).update({
        'latitude': latitude,
        'longitude': longitude,
      });
      return 'Your Location has been updated successfully!';
    } catch (e) {
      return 'Failed to update location!';
    }
  }

  // 🔐 Email & Password Login
  Future<String?> loginUser({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // 🔐 Google Sign In
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return 'Sign in aborted';

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user == null) return 'Sign-in failed. No user data';

      // 🔍 Check if user is already registered (exists in Firestore)
      final isRegistered = await checkIfUserExists(user.uid);
      if (!isRegistered) {
        // 🚫 User not allowed — delete the FirebaseAuth user
        await user.delete(); // Removes the auto-created auth record
        await FirebaseAuth.instance.signOut();
        return 'This Email is not registered. Please register first.';
      }

      return null; // ✅ Success
    } catch (e) {
      return 'Google sign-in failed: $e';
    }
  }


  Future<bool> checkIfUserExists(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.exists;
  }
}

