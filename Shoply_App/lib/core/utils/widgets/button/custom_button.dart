import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    this.style,
    this.onPressed,
    this.height,
    this.width,
    this.radius,
  });
  final String buttonText;
  final TextStyle? style;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 62,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(radius ?? 18),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        child: Text(
          buttonText,
          style:
              style ??
              TextStyle(
                fontSize: 30,
                color: AppColors.onPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
