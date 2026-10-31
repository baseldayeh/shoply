import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/model/order/products_order.dart';
import 'package:shoply_app/features/cart/repo/cart_repo.dart';
import 'package:shoply_app/features/cart/view_model/state.dart';
import 'package:shoply_app/features/main/view_model/cubit.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitState());
  final _cartRepo = CartRepo();
  final List<Cart> responseCart = [];

  Future<void> refreshCart() async {
    responseCart.clear();
    await getCart();
  }

  Future<void> getCart() async {
    emit(CartLoadingState());
    final result = await _cartRepo.getCart();
    result.fold(
      (errorMessage) {
        emit(CartErrorState(errorMessage: errorMessage));
      },
      (responseCart) {
        this.responseCart.addAll(responseCart);
        emit(CartSuccessState());
      },
    );
  }

  Future<void> deleteProduct({
    required String productId,
    required BuildContext context,
  }) async {
    context.read<MainCubit>().decrementCartCount();
    responseCart.removeWhere((product) => product.id == productId);
    _cartRepo.deletePorduct(productId: productId);
    emit(CartDeleteProductSuccessState());
  }

  void incrementQuantity({required int index}) {
    int quantity = responseCart[index].quantity ?? 0;

    if (quantity < 10) {
      quantity++;
      responseCart[index].quantity = quantity;
      _updateQuantity(index: index);
      emit(CartUpdateQuantitySuccessState());
    }
  }

  void decrementQuantity({required int index}) {
    int quantity = responseCart[index].quantity ?? 0;
    if (quantity > 1) {
      quantity--;
      responseCart[index].quantity = quantity;
      _updateQuantity(index: index);
      emit(CartUpdateQuantitySuccessState());
    }
  }

  Future<void> _updateQuantity({required int index}) async {
    await _cartRepo.updateQuantity(
      productId: responseCart[index].id ?? '',
      quantity: responseCart[index].quantity ?? 0,
    );
  }

  double get subTotal {
    double total = 0;

    for (final cart in responseCart) {
      total += (cart.price ?? 0) * (cart.quantity ?? 0);
    }

    return total;
  }

  Future<void> checkOut({required BuildContext context}) async {
    emit(CartCheckoutLoadingState());
    final result = await _cartRepo.checkout(
      requestProductsOrder: ProductsOrder(
        userUid: LocalStorageUser.instance.uid,
        fullName: LocalStorageUser.instance.fullName,
        address: LocalStorageUser.instance.address,
        subTotal: subTotal,
        cart: responseCart,
        status: 'pending',
      ),
    );
    result.fold(
      (errorMessage) {
        emit(CartCheckoutErrorState(errorMessage: errorMessage));
      },
      (_) {
        context.read<MainCubit>().removeCartCount();
        responseCart.clear();
        _cartRepo.deleteAllPorduct();
        emit(CartCheckoutSuccessState());
      },
    );
  }
}
