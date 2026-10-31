part of '../signup_screen.dart';

class _SignupNameTextfield extends StatelessWidget {
  const _SignupNameTextfield();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return Column(
      children: [
        CustomTextField(
          validator: (fullName) {
            if (fullName?.isEmpty ?? false) {
              return 'Full Name is required';
            }
            return null;
          },
          controller: cubit.fullNameController,
          hinText: 'Full Name',
          prefixIcon: Icon(
            Icons.person_outlined,
            size: 28,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 15),
        CustomTextField(
          validator: (userName) {
            if (userName?.isEmpty ?? false) {
              return 'Username is required';
            }
            return null;
          },
          controller: cubit.userNameController,
          hinText: 'Username',
          prefixIcon: Icon(
            Icons.person_outlined,
            size: 28,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }
}
