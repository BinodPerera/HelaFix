import 'dart:convert';
import 'dart:typed_data';

class Service {
  final String? id;
  final String name; 
  final String description;
  final String imageBase64;
  final String subCategoryId;
  final String providerId;
  final String categoryId;

  Service({
    this.id,
    required this.name,
    required this.description,
    required this.imageBase64,
    required this.subCategoryId,
    required this.providerId,
    required this.categoryId,
  });

  factory Service.fromMap(Map<String, dynamic> data, String? id) {
    return Service(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageBase64: data['image_base64'] ?? '',
      categoryId: data['category_id'] ?? '',
      subCategoryId: data['sub_category_id'] ?? '',
      providerId: data['provider_id'] ?? '',
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