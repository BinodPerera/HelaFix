class Category {
  final String name;

  Category({ required this.name });

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
      name: data['name'] ?? ''
    );
  }
}