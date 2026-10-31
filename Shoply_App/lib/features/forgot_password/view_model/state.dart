abstract class ForgotPasswordState {}

class ForgotPasswordInitState extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordErrorState extends ForgotPasswordState {
  final String errorMessage;

  ForgotPasswordErrorState({required this.errorMessage});
}

class ForgotPasswordSuccessState extends ForgotPasswordState {
  final String successMessage;

  ForgotPasswordSuccessState({required this.successMessage});
}
