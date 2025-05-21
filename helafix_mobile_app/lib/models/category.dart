class Category {
  final String name;
  final String? id;

  Category({ required this.name, this.id });

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
      id: data['_id'] ?? '',
      name: data['name'] ?? ''
    );
  }
}