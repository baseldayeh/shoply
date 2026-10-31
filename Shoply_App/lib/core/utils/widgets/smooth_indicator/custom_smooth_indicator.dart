import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothIndicator extends StatelessWidget {
  const CustomSmoothIndicator({
    super.key,
    required this.pageController,
    required this.count,
    this.effect,
  });
  final PageController pageController;
  final int count;
  final IndicatorEffect? effect;
  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: count,
      effect:
          effect ??
          WormEffect(
            spacing: 8.0,
            radius: 20.0,
            dotWidth: 16.0,
            dotHeight: 16.0,
            strokeWidth: 1.5,
            dotColor: AppColors.primaryColor.withValues(alpha: 0.3),
            activeDotColor: AppColors.primaryColor,
          ),
    );
  }
}
