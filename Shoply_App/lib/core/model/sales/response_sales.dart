class ResponseSales {
  final String? id;
  final String? image;

  ResponseSales({required this.id, required this.image});

  factory ResponseSales.fromJson(Map<String, dynamic> json) {
    return ResponseSales(id: json['id'], image: json['image']);
  }
}
