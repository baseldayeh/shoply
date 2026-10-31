import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/models/store_order.dart';

abstract interface class OrdersRepository {
  Stream<List<StoreOrder>> watchOrders();
  Future<void> updateStatus(String orderId, String status);
}

class FirestoreOrdersRepository implements OrdersRepository {
  FirestoreOrdersRepository(this._db);
  final FirebaseFirestore _db;
  @override
  Stream<List<StoreOrder>> watchOrders() => _db
      .collection('Order')
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) => StoreOrder.fromMap(doc.id, doc.data()))
            .toList(),
      );
  @override
  Future<void> updateStatus(String orderId, String status) =>
      _db.collection('Order').doc(orderId).update({'status': status});
}
