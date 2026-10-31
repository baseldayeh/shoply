part of '../signup_screen.dart';

class _SignupEmailAddressTextfield extends StatelessWidget {
  const _SignupEmailAddressTextfield();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    return Column(
      children: [
        CustomTextField(
          validator: (email) {
            if (email?.isEmpty ?? false) {
              return 'Email is required';
            } else if (AppRegex.emailRegex.hasMatch(email ?? '') == false) {
              return 'Email is not valid';
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
        SizedBox(height: 15),
        CustomTextField(
          validator: (address) {
            if (address?.isEmpty ?? false) {
              return 'Address is required';
            }
            return null;
          },
          controller: cubit.addressController,
          hinText: 'Address',
          prefixIcon: Icon(
            Icons.location_on_outlined,
            size: 28,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }
}
