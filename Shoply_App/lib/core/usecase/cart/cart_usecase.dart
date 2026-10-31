import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/core/model/cart/cart.dart';

class CartUsecase {
  Future<Either<String, bool>> addToCart({required Cart requestCart}) async {
    try {
      final snapshot = FirebaseFirestore.instance
          .collection('User')
          .doc(LocalStorageUser.instance.uid)
          .collection('cart')
          .doc(requestCart.id);

      final cartRef = await snapshot.get();

      if (cartRef.exists) {
        await cartRef.reference.update({
          'quantity': FieldValue.increment(requestCart.quantity ?? 0),
        });
      } else {
        await cartRef.reference.set(requestCart.toJson());
      }

      return Right(true);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, List<Cart>>> getCart() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(LocalStorageUser.instance.uid)
          .collection('cart')
          .get();
      final List<Cart> responseCart = [];
      for (var cart in snapshot.docs) {
        responseCart.add(Cart.fromJson(cart.data()));
      }

      return Right(responseCart);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, bool>> deletePorduct({
    required String productId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(LocalStorageUser.instance.uid)
          .collection('cart')
          .doc(productId)
          .delete();
      return Right(true);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, bool>> deleteAllPorduct() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(LocalStorageUser.instance.uid)
          .collection('cart')
          .get();

      for (var cart in snapshot.docs) {
        cart.reference.delete();
      }

      return Right(true);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, bool>> updateQuantity({
    required int quantity,
    required String productId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(LocalStorageUser.instance.uid)
          .collection('cart')
          .doc(productId)
          .update({'quantity': quantity});
      return Right(true);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }

  Future<Either<String, int>> getCartCount() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(LocalStorageUser.instance.uid)
          .collection('cart')
          .get();
      return Right(snapshot.docs.length);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
