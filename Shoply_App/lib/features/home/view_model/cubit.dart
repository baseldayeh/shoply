import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/categories/ressponse_categories.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/core/model/sales/response_sales.dart';
import 'package:shoply_app/features/home/repo/home_repo.dart';
import 'package:shoply_app/features/home/view_model/state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());
  final _homeRepo = HomeRepo();
  ResponseSales? responseSales;
  final List<RessponseCategories> ressponseCategories = [];
  final List<ResponseProducts> responseProducts = [];
  String? _errorMessage;

  Future<void> refreshData() async {
    responseSales = null;
    ressponseCategories.clear();
    responseProducts.clear();
    _errorMessage = null;
    await getHome();
  }

  Future<void> getHome() async {
    emit(HomeLoadingState());
    await Future.wait([_getSales(), _getCategories(), _getTrendingProducts()]);
    if (_errorMessage != null) {
      emit(HomeErrorState(errorMessage: _errorMessage ?? ''));
    } else {
      emit(HomeSuccessState());
    }
  }

  Future<void> _getSales() async {
    final result = await _homeRepo.getSales();
    result.fold(
      (errorMessage) {
        _errorMessage = errorMessage;
      },
      (responseSales) {
        this.responseSales = responseSales;
      },
    );
  }

  Future<void> _getCategories() async {
    final result = await _homeRepo.getCategories();
    result.fold(
      (errorMessage) {
        _errorMessage = errorMessage;
      },
      (ressponseCategories) {
        this.ressponseCategories.addAll(ressponseCategories);
      },
    );
  }

  Future<void> _getTrendingProducts() async {
    final result = await _homeRepo.getTrendingProducts();
    result.fold(
      (errorMessage) {
        _errorMessage = errorMessage;
      },
      (responseProducts) {
        this.responseProducts.addAll(responseProducts);
      },
    );
  }
}
