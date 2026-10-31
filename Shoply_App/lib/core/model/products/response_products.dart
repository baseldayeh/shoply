class ResponseProducts {
  final String? id;
  final String? name;
  final String? description;
  final bool? isTrending;
  final double? price;
  final List<String> images;

  ResponseProducts({
    required this.id,
    required this.name,
    required this.description,
    required this.isTrending,
    required this.price,
    required this.images,
  });

  factory ResponseProducts.fromJson(Map<String, dynamic> json) {
    final List<String> imagesData = [];
    for (final image in (json['image'] as List? ?? const [])) {
      if (image is String) imagesData.add(image);
    }
    return ResponseProducts(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isTrending: json['isTrending'],
      price: (json['price'] as num?)?.toDouble(),
      images: imagesData,
    );
  }
}
