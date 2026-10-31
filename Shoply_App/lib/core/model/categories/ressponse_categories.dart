class RessponseCategories {
  final String? id;
  final String? name;
  final String? image;

  RessponseCategories({
    required this.id,
    required this.name,
    required this.image,
  });

  factory RessponseCategories.fromJson(Map<String, dynamic> json) {
    return RessponseCategories(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
