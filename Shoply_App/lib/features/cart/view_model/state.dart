abstract class CartState {}

class CartInitState extends CartState {}

class CartLoadingState extends CartState {}

class CartErrorState extends CartState {
  final String errorMessage;

  CartErrorState({required this.errorMessage});
}

class CartSuccessState extends CartState {}

class CartDeleteProductSuccessState extends CartState {}

class CartUpdateQuantitySuccessState extends CartState {}

class CartCheckoutLoadingState extends CartState {}

class CartCheckoutErrorState extends CartState {
  final String errorMessage;

  CartCheckoutErrorState({required this.errorMessage});
}

class CartCheckoutSuccessState extends CartState {}
