import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/order/products_order.dart';

class CheckoutUsecase {
  Future<Either<String, bool>> checkout({
    required ProductsOrder requestProductsOrder,
  }) async {
    try {
      final orderId = FirebaseFirestore.instance.collection('Order').doc().id;
      requestProductsOrder.id = orderId;
      await FirebaseFirestore.instance
          .collection('Order')
          .doc(orderId)
          .set(requestProductsOrder.toJson());
      return Right(true);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
