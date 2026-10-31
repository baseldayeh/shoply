class Cart {
  final String? id;
  final String? name;
  final double? price;
  int? quantity;
  final List<String>? images;

  Cart({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.images,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final List<String> imagesData = [];
    for (var image in json['image']) {
      imagesData.add(image);
    }
    return Cart(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      images: imagesData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': images,
    };
  }
}
