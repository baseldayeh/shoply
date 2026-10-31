abstract class CategoriesState {}

class CategoriesInitState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesErrorState extends CategoriesState {
  final String errorMessage;

  CategoriesErrorState({required this.errorMessage});
}

class CategoriesSuccessState extends CategoriesState {}
