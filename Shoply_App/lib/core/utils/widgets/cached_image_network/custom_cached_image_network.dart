import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';

class CustomCachedImageNetwork extends StatelessWidget {
  const CustomCachedImageNetwork({
    super.key,
    required this.image,
    this.errorWidget,
    this.height,
    this.width,
    this.fit,
  });
  final String image;
  final Widget? errorWidget;
  final double? height;
  final double? width;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height ?? 120,
      width: width ?? 150,
      imageUrl: image,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Icon(Icons.error_outline, size: 28, color: AppColors.error),
    );
  }
}
