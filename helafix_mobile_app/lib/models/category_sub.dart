class SubCategory {
  final String? id;
  final String name;
  final String categoryId;

  SubCategory({ this.id, required this.name, required this.categoryId });

  factory SubCategory.fromMap(Map<String, dynamic> data, String? id) {
    return SubCategory(
      id: id,
      name: data['name'] ?? '',
      categoryId: data['category_id'] ?? ''
    );
  }
}