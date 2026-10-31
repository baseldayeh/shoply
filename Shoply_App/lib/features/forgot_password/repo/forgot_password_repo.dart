import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/usecase/forgot_password/forgot_password_usecase.dart';

class ForgotPasswordRepo {
  final _forgotPasswordUsecase = ForgotPasswordUsecase();

  Future<Either<String, bool>> forgotPassword({required String email}) async {
    return await _forgotPasswordUsecase.forgotPassword(email: email);
  }
}
