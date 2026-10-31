import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_dialog_error.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_success_dialog.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/smooth_indicator/custom_smooth_indicator.dart';
import 'package:shoply_app/features/product_details/view_model/cubit.dart';
import 'package:shoply_app/features/product_details/view_model/state.dart';
part 'widgets/product_details_top.dart';
part 'widgets/product_details_body.dart';
part 'widgets/product_details_bottom.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.responseProducts});
  final ResponseProducts responseProducts;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit()
            ..checkIfProductInFavourite(productId: responseProducts.id ?? ''),
      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              buildWhen: (previous, current) {
                return current is ProductDetailsChangeFavouriteState ||
                    current is ProductDetailsFavouriteLoadingState ||
                    current is ProductDetailsFavouriteErrorState ||
                    current is ProductDetailsFavouriteSucessState;
              },
              builder: (context, state) {
                final cubit = context.read<ProductDetailsCubit>();
                return GestureDetector(
                  onTap: () {
                    cubit.changeIsFavourite(
                      responseProducts: responseProducts,
                      context: context,
                    );
                  },
                  child: Icon(
                    cubit.isFavourite ? Icons.favorite : Icons.favorite_outline,
                    size: 28,
                    color: Colors.red,
                  ),
                );
              },
            ),
            SizedBox(width: 10),
          ],
        ),
        body: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
          listenWhen: (previous, current) {
            return current is! ProductDetailsChangeQuantityState;
          },
          listener: (context, state) {
            if (state is ProductDetailsAddToCartLoadingState) {
              CustomLoading.showDialogLoading(context: context);
            } else if (state is ProductDetailsAddToCartErrorState) {
              Navigator.pop(context);
              CustomDialogError.showProDialogError(
                context: context,
                title: 'Add to Cart',
                description: state.errorMessage,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            } else if (state is ProductDetailsAddToCartSuccessState) {
              Navigator.pop(context);
              CustomSuccessDialog.showProSuccessDialog(
                context: context,
                title: 'Add to Cart',
                description: 'Add to cart successfuly.',
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _ProductDetailsTop(responseProducts: responseProducts),
                  SizedBox(height: 35),
                  _ProductDetailsBody(responseProducts: responseProducts),
                  SizedBox(height: 30),
                  _ProductDetailsBottom(responseProducts: responseProducts),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
