class SubCategory {
  final String name;
  final String categoryId;

  SubCategory({required this.name, required this.categoryId});

  factory SubCategory.fromMap(Map<String, dynamic> data) {
    return SubCategory(
      name: data['name'] ?? '',
      categoryId: data['category_id'] ?? '',
    );
  }
}
