import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/features/products/repo/products_repo.dart';
import 'package:shoply_app/features/products/view_model/state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitState());

  final _productsRepo = ProductsRepo();
  final List<ResponseProducts> responseProducts = [];

  Future<void> refreshProducts({required String categoryId}) async {
    responseProducts.clear();
    await getProducts(categoryId: categoryId);
  }

  Future<void> getProducts({required String categoryId}) async {
    emit(ProductsLoadingState());
    final result = await _productsRepo.getProducts(categoryId: categoryId);
    result.fold(
      (errorMessage) {
        emit(ProductsErrorState(errorMessage: errorMessage));
      },
      (responseProducts) {
        this.responseProducts.addAll(responseProducts);
        emit(ProductsSuccessState());
      },
    );
  }
}
