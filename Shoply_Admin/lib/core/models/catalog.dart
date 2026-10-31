class Category {
  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
  final String id;
  final String name;
  final String imageUrl;

  factory Category.fromMap(String id, Map<String, dynamic> data) => Category(
    id: id,
    name: data['name'] as String? ?? '',
    imageUrl: data['image'] as String? ?? '',
  );
  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'image': imageUrl};
}

class Product {
  const Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.isTrending,
  });
  final String id, categoryId, name, description;
  final double price;
  final List<String> images;
  final bool isTrending;

  factory Product.fromMap(
    String id,
    String categoryId,
    Map<String, dynamic> data,
  ) => Product(
    id: id,
    categoryId: categoryId,
    name: data['name'] as String? ?? '',
    description: data['description'] as String? ?? '',
    price: (data['price'] as num?)?.toDouble() ?? 0,
    images: (data['image'] as List? ?? const []).whereType<String>().toList(),
    isTrending: data['isTrending'] == true,
  );
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'image': images,
    'isTrending': isTrending,
  };
}

class StoreBanner {
  const StoreBanner({required this.id, required this.imageUrl});
  final String id, imageUrl;
  factory StoreBanner.fromMap(String id, Map<String, dynamic> data) =>
      StoreBanner(id: id, imageUrl: data['image'] as String? ?? '');
}
