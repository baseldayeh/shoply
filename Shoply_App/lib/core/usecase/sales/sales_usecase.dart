import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/sales/response_sales.dart';

class SalesUsecase {
  Future<Either<String, ResponseSales?>> getSales() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Sales')
          .get();

      return Right(
        snapshot.docs.isEmpty
            ? null
            : ResponseSales.fromJson(snapshot.docs.first.data()),
      );
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
