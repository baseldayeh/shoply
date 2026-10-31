import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/smooth_indicator/custom_smooth_indicator.dart';
import 'package:shoply_app/core/utils/widgets/text_button/custom_text_button.dart';
import 'package:shoply_app/features/onboarding/view_model/cubit.dart';
import 'package:shoply_app/features/onboarding/view_model/state.dart';
part 'widgets/on_boarding_header.dart';
part 'widgets/on_boarding_bottom.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    SizedBox(
                      height: (constraints.maxHeight * .65).clamp(320.0, 600.0),
                      child: _OnBoardingHeader(),
                    ),
                    const SizedBox(height: 20),
                    _OnBoardingBottom(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
