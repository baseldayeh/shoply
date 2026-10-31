part of '../login_screen.dart';

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Column(
      children: [
        CustomTextField(
          validator: (email) {
            if (email?.isEmpty ?? false) {
              return 'Email is required';
            }
            return null;
          },
          controller: cubit.emailController,
          hinText: 'Email',
          prefixIcon: Icon(
            Icons.email_outlined,
            size: 28,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 30),
        CustomTextField(
          validator: (password) {
            if (password?.isEmpty ?? false) {
              return 'Password is required';
            }
            return null;
          },
          obscureText: true,
          controller: cubit.passwordController,
          hinText: 'Password',
          prefixIcon: Icon(
            Icons.lock_outline,
            size: 28,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppPages.forgotPasswordScreen);
          },
          child: Align(
            alignment: AlignmentGeometry.centerRight,
            child: Text(
              'ForgotPassword?',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
