import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutUsecase {
  Future<Either<String, bool>> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return Right(true);
    } on FirebaseException catch (e) {
      return Left(e.message ?? '');
    }
  }
}
