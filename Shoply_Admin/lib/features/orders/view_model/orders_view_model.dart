import '../../../core/models/store_order.dart';
import '../data/orders_repository.dart';

class OrdersViewModel {
  OrdersViewModel(this._repository);
  final OrdersRepository _repository;
  Stream<List<StoreOrder>> watchOrders() => _repository.watchOrders();
  static const statuses = ['Pending', 'Processing', 'Completed', 'Cancelled'];
  Future<void> setStatus(String id, String status) {
    if (!statuses.contains(status)) throw ArgumentError.value(status, 'status');
    return _repository.updateStatus(id, status);
  }
}
