import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';

class CustomTextButtonWrap extends StatelessWidget {
  const CustomTextButtonWrap({
    super.key,
    required this.text,
    required this.textClick,
    this.onTap,
  });
  final String text;
  final String textClick;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            textClick,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
