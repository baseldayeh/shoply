import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/local/local_storage.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/core/model/login/request_login.dart';
import 'package:shoply_app/features/login/repo/login_repo.dart';
import 'package:shoply_app/features/login/view_model/state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  final _loginRepo = LoginRepo();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(LoginLoadingState());
      final result = await _loginRepo.login(
        requestLogin: RequestLogin(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      result.fold(
        (errorMessage) {
          emit(LoginErrorState(errorMessage: errorMessage));
        },
        (responseLogin) async {
          await LocalStorage.instance.setIsLogin(isLogin: true);
          await LocalStorageUser.instance.setUserData(
            responseLogin: responseLogin,
          );
          LocalStorageUser.instance.setUserinfo(responseLogin: responseLogin);
          emit(LoginSuccessState());
        },
      );
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
