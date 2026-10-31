class OrderItem {
  const OrderItem({required this.name, required this.quantity});
  final String name;
  final int quantity;
  factory OrderItem.fromMap(Map<String, dynamic> data) => OrderItem(
    name: data['name'] as String? ?? 'Product',
    quantity: (data['quantity'] as num?)?.toInt() ?? 1,
  );
}

class StoreOrder {
  const StoreOrder({
    required this.id,
    required this.customerName,
    required this.address,
    required this.total,
    required this.status,
    required this.items,
  });
  final String id, customerName, address, status;
  final double total;
  final List<OrderItem> items;
  factory StoreOrder.fromMap(String id, Map<String, dynamic> data) =>
      StoreOrder(
        id: id,
        customerName: data['fullName'] as String? ?? 'Customer',
        address: data['address'] as String? ?? '—',
        total: (data['subTotal'] as num?)?.toDouble() ?? 0,
        status: data['status'] as String? ?? 'Pending',
        items: (data['cart'] as List? ?? const [])
            .whereType<Map>()
            .map((item) => OrderItem.fromMap(Map<String, dynamic>.from(item)))
            .toList(),
      );
}
