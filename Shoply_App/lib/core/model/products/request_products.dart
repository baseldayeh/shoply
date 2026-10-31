class RequestProducts {
  final String? id;
  final String? name;
  final String? description;
  final double? price;
  final List<String>? images;

  RequestProducts({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': images,
    };
  }
}
