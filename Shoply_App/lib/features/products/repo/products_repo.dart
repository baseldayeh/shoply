import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/core/usecase/products/products_usecase.dart';

class ProductsRepo {
  final _productsUsecase = ProductsUsecase();

  Future<Either<String, List<ResponseProducts>>> getProducts({
    required String categoryId,
  }) async {
    return await _productsUsecase.getProducts(categoryId: categoryId);
  }
}
