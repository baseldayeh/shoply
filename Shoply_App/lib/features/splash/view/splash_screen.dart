import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/images/app_images.dart';
import 'package:shoply_app/features/splash/view_model/cubit.dart';
import 'package:shoply_app/features/splash/view_model/state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..goNextPage(),
      child: Scaffold(
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashOnBoardPageState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.onBoardingScreen,
                (route) => false,
              );
            } else if (state is SplashLoginPageState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.loginScreen,
                (route) => false,
              );
            } else if (state is SplashMainPageState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.mainScreen,
                (route) => false,
              );
            }
          },
          child: Center(
            child: Image(
              image: AssetImage(AppImages.shoplySplashImage),
              height: 350,
              width: 350,
            ),
          ),
        ),
      ),
    );
  }
}
