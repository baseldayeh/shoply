import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/categories/ressponse_categories.dart';

class CategoriesUsecase {
  Future<Either<String, List<RessponseCategories>>> getCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Categories')
          .get();

      final List<RessponseCategories> categoriesData = [];

      for (var category in snapshot.docs) {
        categoriesData.add(RessponseCategories.fromJson(category.data()));
      }
      return Right(categoriesData);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
