import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/categories/ressponse_categories.dart';
import 'package:shoply_app/core/usecase/categories/categories_usecase.dart';

class CategoriesRepo {
  final _categoriesUsecase = CategoriesUsecase();

  Future<Either<String, List<RessponseCategories>>> getCategories() async {
    return await _categoriesUsecase.getCategories();
  }
}
