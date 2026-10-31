import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/features/forgot_password/repo/forgot_password_repo.dart';
import 'package:shoply_app/features/forgot_password/view_model/state.dart';

class ForgotPassswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPassswordCubit() : super(ForgotPasswordInitState());
  final _forgotPasswordRepo = ForgotPasswordRepo();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> forgotPassword() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(ForgotPasswordLoadingState());
      final result = await _forgotPasswordRepo.forgotPassword(
        email: emailController.text,
      );
      result.fold(
        (errorMessage) {
          emit(ForgotPasswordErrorState(errorMessage: errorMessage));
        },
        (_) {
          emit(
            ForgotPasswordSuccessState(
              successMessage: 'Send Reset Email Successfuly',
            ),
          );
        },
      );
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
