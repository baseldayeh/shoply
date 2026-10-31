part of '../login_screen.dart';

class _LoginBottom extends StatelessWidget {
  const _LoginBottom();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Column(
      children: [
        CustomButton(
          buttonText: 'Login',
          onPressed: () {
            cubit.login();
          },
        ),
        SizedBox(height: 50),
        CustomTextButtonWrap(
          text: 'Don\'t have an account?',
          textClick: ' Sign Up',
          onTap: () {
            Navigator.pushNamed(context, AppPages.signupScreen);
          },
        ),
      ],
    );
  }
}
