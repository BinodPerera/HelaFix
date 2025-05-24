import 'dart:typed_data';
import 'dart:convert';

class ServiceProvider {
  final String? id;
  final String name;
  final String description;
  final String imageBase64;
  final List<String> services; // <-- Added for the 'sp' array

  ServiceProvider({
    this.id,
    required this.name,
    required this.description,
    required this.imageBase64,
    required this.services,
  });

  factory ServiceProvider.fromMap(Map<String, dynamic> data, String? id) {
    return ServiceProvider(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageBase64: data['image_base64'] ?? '',
      services: List<String>.from(data['sp'] ?? []), // Safely parse the array
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image_base64': imageBase64,
      'sp': services,
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
