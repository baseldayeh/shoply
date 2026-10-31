import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shoply_app/core/model/signup/request_signup.dart';
import 'package:shoply_app/core/usecase/signup/signup_usecase.dart';

class SignupRepo {
  final _signupUsecase = SignupUsecase();

  Future<Either<String, bool>> signup({
    required String password,
    required RequestSignup requestSingup,
    required File? image,
  }) async {
    return await _signupUsecase.signup(
      image: image,
      password: password,
      requestSignup: requestSingup,
    );
  }
}
