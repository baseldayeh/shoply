import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/core/model/products/request_products.dart';
import 'package:shoply_app/core/model/products/response_products.dart';

class FavouriteUsecase {
  Future<Either<String, bool>> addToFavourite({
    required RequestProducts requestProducts,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(LocalStorageUser.instance.uid)
          .collection('favourite')
          .doc(requestProducts.id)
          .set(requestProducts.toJson());
      return Right(true);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, bool>> removeToFavourite({
    required String productId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(LocalStorageUser.instance.uid)
          .collection('favourite')
          .doc(productId)
          .delete();
      return Right(true);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, bool>> checkIfProductInFavourite({
    required String productId,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(LocalStorageUser.instance.uid)
          .collection('favourite')
          .doc(productId)
          .get();

      return Right(snapshot.exists);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, List<ResponseProducts>>> getFavourite() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(LocalStorageUser.instance.uid)
          .collection('favourite')
          .get();

      final List<ResponseProducts> responseProducts = [];

      for (var product in snapshot.docs) {
        responseProducts.add(ResponseProducts.fromJson(product.data()));
      }
      return Right(responseProducts);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, int>> getFavouriteCount() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(LocalStorageUser.instance.uid)
          .collection('favourite')
          .get();

      return Right(snapshot.docs.length);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
