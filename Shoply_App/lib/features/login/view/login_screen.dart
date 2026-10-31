import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/images/app_images.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_dialog_error.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/text_button/custom_text_button_wrap.dart';
import 'package:shoply_app/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_app/features/login/view_model/cubit.dart';
import 'package:shoply_app/features/login/view_model/state.dart';
part 'widgets/login_header.dart';
part 'widgets/login_body.dart';
part 'widgets/login_bottom.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoadingState) {
              CustomLoading.showDialogLoading(context: context);
            } else if (state is LoginErrorState) {
              Navigator.pop(context);
              CustomDialogError.showProDialogError(
                context: context,
                title: 'Login Error',
                description: state.errorMessage,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            } else if (state is LoginSuccessState) {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.mainScreen,
                (route) => false,
              );
            }
          },
          child: Builder(
            builder: (context) {
              final cubit = context.read<LoginCubit>();
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Form(
                        key: cubit.formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            _LoginHeader(),
                            SizedBox(height: 50),
                            _LoginBody(),
                            SizedBox(height: 50),
                            _LoginBottom(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
