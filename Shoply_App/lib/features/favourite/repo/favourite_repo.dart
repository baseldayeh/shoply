import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/core/usecase/cart/cart_usecase.dart';
import 'package:shoply_app/core/usecase/favourite/favourite_usecase.dart';

class FavouriteRepo {
  final _favouriteUsecase = FavouriteUsecase();
  final _cartUsecase = CartUsecase();

  Future<Either<String, bool>> addToCart({required Cart requestCart}) async {
    return await _cartUsecase.addToCart(requestCart: requestCart);
  }

  Future<Either<String, List<ResponseProducts>>> getFavourite() async {
    return await _favouriteUsecase.getFavourite();
  }

  Future<Either<String, bool>> removeToFavourite({
    required String productId,
  }) async {
    return await _favouriteUsecase.removeToFavourite(productId: productId);
  }
}
