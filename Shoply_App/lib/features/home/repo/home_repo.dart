import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/categories/ressponse_categories.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/core/model/sales/response_sales.dart';
import 'package:shoply_app/core/usecase/categories/categories_usecase.dart';
import 'package:shoply_app/core/usecase/products/products_usecase.dart';
import 'package:shoply_app/core/usecase/sales/sales_usecase.dart';

class HomeRepo {
  final _salesUsecase = SalesUsecase();
  final _categoriesUsecase = CategoriesUsecase();
  final _productsUsecase = ProductsUsecase();

  Future<Either<String, ResponseSales?>> getSales() async {
    return await _salesUsecase.getSales();
  }

  Future<Either<String, List<RessponseCategories>>> getCategories() async {
    return await _categoriesUsecase.getCategories();
  }

  Future<Either<String, List<ResponseProducts>>> getTrendingProducts() async {
    return await _productsUsecase.getTrendingProducts();
  }
}
