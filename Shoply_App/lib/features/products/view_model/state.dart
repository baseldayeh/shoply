abstract class ProductsState {}

class ProductsInitState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsErrorState extends ProductsState {
  final String errorMessage;

  ProductsErrorState({required this.errorMessage});
}

class ProductsSuccessState extends ProductsState {}
