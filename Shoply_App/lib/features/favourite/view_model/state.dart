abstract class FavouriteState {}

class FavouriteInitState extends FavouriteState {}

class FavouriteLoadingState extends FavouriteState {}

class FavouriteErrorState extends FavouriteState {
  final String errorMessage;

  FavouriteErrorState({required this.errorMessage});
}

class FavouriteSucessState extends FavouriteState {}

class FavouriteRemoveSucessState extends FavouriteState {}

class FavouriteAddToCartLoadingState extends FavouriteState {}

class FavouriteAddToCartErrorState extends FavouriteState {
  final String errorMessage;

  FavouriteAddToCartErrorState({required this.errorMessage});
}

class FavouriteAddToCartSuccessState extends FavouriteState {}
