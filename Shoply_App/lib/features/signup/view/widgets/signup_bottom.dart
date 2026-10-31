part of '../signup_screen.dart';

class _SignupBottom extends StatelessWidget {
  const _SignupBottom();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    return Column(
      children: [
        CustomButton(
          buttonText: 'Sign Up',
          onPressed: () {
            cubit.signup();
          },
        ),
        SizedBox(height: 30),
        CustomTextButtonWrap(
          text: 'Already have an account?',
          textClick: ' Login',
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppPages.loginScreen,
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}
