import 'dart:typed_data';
import 'dart:convert';

class Category {
  final String name;
  final String? id;
  final String imageBase64;

  Category({ required this.name, this.id, required this.imageBase64 });

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
      id: data['_id'] ?? '',
      name: data['name'] ?? '',
      imageBase64: data['image_base64'] ?? '',
    );
  }

  Uint8List? get imageBytes {
    try {
      return base64Decode(imageBase64);
    } catch (_) {
      return null;
    }
  }
}