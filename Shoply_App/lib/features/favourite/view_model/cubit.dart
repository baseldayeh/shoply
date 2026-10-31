import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/features/favourite/repo/favourite_repo.dart';
import 'package:shoply_app/features/favourite/view_model/state.dart';
import 'package:shoply_app/features/main/view_model/cubit.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitState());
  final _favouriteRepo = FavouriteRepo();

  final List<ResponseProducts> responseProducts = [];

  Future<void> refreshFavourite() async {
    responseProducts.clear();
    await getFavourite();
  }

  Future<void> getFavourite() async {
    emit(FavouriteLoadingState());
    final result = await _favouriteRepo.getFavourite();
    result.fold(
      (errorMessage) {
        emit(FavouriteErrorState(errorMessage: errorMessage));
      },
      (responseProducts) {
        this.responseProducts.addAll(responseProducts);
        emit(FavouriteSucessState());
      },
    );
  }

  void removeProductFromFav({
    required String productId,
    required BuildContext context,
  }) {
    responseProducts.removeWhere((product) => product.id == productId);
    context.read<MainCubit>().decrementFavouriteCount();
    _removeToFavourite(productId: productId);
    emit(FavouriteRemoveSucessState());
  }

  Future<void> _removeToFavourite({required String productId}) async {
    await _favouriteRepo.removeToFavourite(productId: productId);
  }

  Future<void> addToCart({
    required Cart requestCart,
    required BuildContext context,
  }) async {
    emit(FavouriteAddToCartLoadingState());
    final result = await _favouriteRepo.addToCart(requestCart: requestCart);

    result.fold(
      (errorMessage) {
        emit(FavouriteAddToCartErrorState(errorMessage: errorMessage));
      },
      (_) {
        context.read<MainCubit>().getCartCount();
        emit(FavouriteAddToCartSuccessState());
      },
    );
  }
}
