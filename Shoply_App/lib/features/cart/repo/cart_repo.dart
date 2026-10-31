import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/model/order/products_order.dart';
import 'package:shoply_app/core/usecase/cart/cart_usecase.dart';
import 'package:shoply_app/core/usecase/checkout/checkout_usecase.dart';

class CartRepo {
  final _cartUsecase = CartUsecase();
  final _checkoutUsecase = CheckoutUsecase();

  Future<Either<String, bool>> checkout({
    required ProductsOrder requestProductsOrder,
  }) async {
    return _checkoutUsecase.checkout(
      requestProductsOrder: requestProductsOrder,
    );
  }

  Future<Either<String, List<Cart>>> getCart() async {
    return await _cartUsecase.getCart();
  }

  Future<Either<String, bool>> deletePorduct({
    required String productId,
  }) async {
    return await _cartUsecase.deletePorduct(productId: productId);
  }

  Future<Either<String, bool>> deleteAllPorduct() async {
    return await _cartUsecase.deleteAllPorduct();
  }

  Future<Either<String, bool>> updateQuantity({
    required String productId,
    required int quantity,
  }) async {
    return await _cartUsecase.updateQuantity(
      productId: productId,
      quantity: quantity,
    );
  }
}
