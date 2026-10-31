import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/helper/image_picker_helper.dart';
import 'package:shoply_app/core/model/signup/request_signup.dart';
import 'package:shoply_app/features/signup/repo/signup_repo.dart';
import 'package:shoply_app/features/signup/view_model/state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitState());
  final _signupRepo = SignupRepo();
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? image;

  void pickImage() async {
    final imageFile = await ImagePickerHelper.pickImageGallery();
    image = File(imageFile?.path ?? '');
    emit(SingupPickImageState());
  }

  void deleteImage() {
    image = null;
    emit(SingupRemoveImageState());
  }

  Future<void> signup() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(SignupLoadingState());
      final result = await _signupRepo.signup(
        image: image,
        password: passwordController.text,
        requestSingup: RequestSignup(
          email: emailController.text,
          fullName: fullNameController.text,
          userName: userNameController.text,
          address: addressController.text,
        ),
      );
      result.fold(
        (errorMessage) {
          emit(SignupErrorState(errorMessage: errorMessage));
        },
        (_) {
          emit(
            SignupSuccessState(successMessage: 'User Register Successfully'),
          );
        },
      );
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    fullNameController.dispose();
    userNameController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
