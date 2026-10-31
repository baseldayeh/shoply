import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/features/categories/view/categories_screen.dart';
import 'package:shoply_app/features/forgot_password/view/forgot_password_screen.dart';
import 'package:shoply_app/features/language/view/language_screen.dart';
import 'package:shoply_app/features/login/view/login_screen.dart';
import 'package:shoply_app/features/main/view/main_screen.dart';
import 'package:shoply_app/features/main/view_model/cubit.dart';
import 'package:shoply_app/features/onboarding/view/on_boarding_screen.dart';
import 'package:shoply_app/features/product_details/view/product_details_screen.dart';
import 'package:shoply_app/features/products/view/products_screen.dart';
import 'package:shoply_app/features/settings/view/settings_screen.dart';
import 'package:shoply_app/features/signup/view/signup_screen.dart';
import 'package:shoply_app/features/splash/view/splash_screen.dart';
import 'package:shoply_app/features/theme/view/theme_screen.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppPages.splashScreen:
        return MaterialPageRoute(
          builder: (context) {
            return SplashScreen();
          },
        );

      case AppPages.onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) {
            return OnBoardingScreen();
          },
        );

      case AppPages.loginScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        );

      case AppPages.signupScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const SignupScreen();
          },
        );

      case AppPages.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const ForgotPasswordScreen();
          },
        );

      case AppPages.mainScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const MainScreen();
          },
        );

      case AppPages.settingsScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const SettingsScreen();
          },
        );

      case AppPages.themeScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const ThemeScreen();
          },
        );

      case AppPages.languageScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const LanguageScreen();
          },
        );

      case AppPages.categoriesScreen:
        return MaterialPageRoute(
          builder: (_) {
            final context = settings.arguments as BuildContext;
            return BlocProvider.value(
              value: context.read<MainCubit>(),
              child: const CategoriesScreen(),
            );
          },
        );

      case AppPages.productsScreen:
        return MaterialPageRoute(
          builder: (_) {
            final arguments = settings.arguments as Map<String, dynamic>;
            final titleText = arguments['titleText'] as String;
            final categoryId = arguments['categoryId'] as String;
            final context = arguments['context'] as BuildContext;
            return BlocProvider.value(
              value: context.read<MainCubit>(),
              child: ProductsScreen(
                titleText: titleText,
                categoryId: categoryId,
              ),
            );
          },
        );

      case AppPages.productsDetailsScreen:
        return MaterialPageRoute(
          builder: (_) {
            final arguments = settings.arguments as Map<String, dynamic>;
            final responseProducts =
                arguments['responseProducts'] as ResponseProducts;
            final context = arguments['context'] as BuildContext;
            return BlocProvider.value(
              value: context.read<MainCubit>(),
              child: ProductDetailsScreen(responseProducts: responseProducts),
            );
          },
        );
    }
    return null;
  }
}
