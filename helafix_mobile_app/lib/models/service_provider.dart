import 'dart:typed_data';
import 'dart:convert';

class ServiceProvider {
  final String? id;
  final String name;
  final String description;
  final String imageBase64;
  final List<String> subcategories;
  final String email; // New field

  ServiceProvider({
    this.id,
    required this.name,
    required this.description,
    required this.imageBase64,
    required this.subcategories,
    required this.email, // Include in constructor
  });

  factory ServiceProvider.fromMap(Map<String, dynamic> data, String? id) {
    return ServiceProvider(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageBase64: data['image_base64'] ?? '',
      subcategories: List<String>.from(data['subcategories'] ?? []),
      email: data['email'] ?? '', // Map email field
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image_base64': imageBase64,
      'subcategories': subcategories,
      'email': email, // Include in map
    };
  }

  Uint8List? get imageBytes {
    try {
      return base64Decode(imageBase64);
    } catch (_) {
      return null;
    }
  }
}

