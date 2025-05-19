import 'dart:typed_data';
import 'dart:convert';

class ServiceProvider {
  final String name;
  final String description;
  final String imageBase64;

  ServiceProvider({required this.name, required this.description, required this.imageBase64});

  factory ServiceProvider.fromMap(Map<String, dynamic> data) {
    return ServiceProvider(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
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
