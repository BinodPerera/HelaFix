class ServiceSubCategory {
  final String id;
  final String categoryId;
  final String name;

  ServiceSubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
  });

  factory ServiceSubCategory.fromMap(Map<String, dynamic> data, String documentId) {
    return ServiceSubCategory(
      id: documentId,
      categoryId: data['category_id'] ?? '',
      name: data['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'name': name,
    };
  }
}

