part of '../product_details_screen.dart';

class _ProductDetailsTop extends StatelessWidget {
  const _ProductDetailsTop({required this.responseProducts});
  final ResponseProducts responseProducts;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: cubit.pageController,
            itemCount: responseProducts.images.length,
            itemBuilder: (context, index) {
              return CustomCachedImageNetwork(
                fit: BoxFit.contain,
                image: responseProducts.images[index],
              );
            },
          ),
        ),
        SizedBox(height: 20),
        CustomSmoothIndicator(
          pageController: cubit.pageController,
          count: responseProducts.images.length,
        ),
      ],
    );
  }
}
