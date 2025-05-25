import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String name;
  final String email;
  final bool? isAdmin;
  final String? image_base64;
  final String phone;
  final double? latitude;
  final double? longtude;
  final Timestamp? createdAt;

  User({
    this.id,
    this.isAdmin,
    this.image_base64,
    this.latitude,
    this.longtude,
    this.createdAt,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory User.fromMap(Map<String, dynamic> data, String? id) {
    return User(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      isAdmin: data['admin'] ?? false,
      image_base64: data['image_base64'] ?? '',
      phone: data['phone'] ?? '',
      latitude: data['latitude'],
      longtude: data['longtude'],
      createdAt: data['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'is_admin': isAdmin,
      'image_base64': image_base64,
      'phone': phone,
      'latitude': latitude,
      'longtude': longtude,
      'created_at': createdAt,
    };
  }
}
