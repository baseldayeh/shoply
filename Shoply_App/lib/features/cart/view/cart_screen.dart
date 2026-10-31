import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_dialog_error.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_success_dialog.dart';
import 'package:shoply_app/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/features/cart/view_model/cubit.dart';
import 'package:shoply_app/features/cart/view_model/state.dart';
import 'widgets/cart_checkout_panel.dart';
part 'widgets/cart_card.dart';
part 'widgets/cart_checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartCheckoutLoadingState) {
            CustomLoading.showDialogLoading(context: context);
          } else if (state is CartCheckoutErrorState) {
            Navigator.pop(context);
            CustomDialogError.showProDialogError(
              context: context,
              title: 'Checkout',
              description: state.errorMessage,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          } else if (state is CartCheckoutSuccessState) {
            Navigator.pop(context);
            CustomSuccessDialog.showProSuccessDialog(
              context: context,
              title: 'Checkout',
              description: 'Checkout Successfully.',
              onPressed: () {
                Navigator.pop(context);
              },
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<CartCubit>();
          if (state is CartLoadingState) {
            return CustomLoadingData();
          } else if (state is CartErrorState) {
            return Center(child: Text(state.errorMessage));
          }
          return CustomRefreshIndicator(
            onRefresh: () async {
              await cubit.refreshCart();
            },
            child: cubit.responseCart.isEmpty
                ? EmptyScreen(emptyText: 'Your cart is empty. Start shopping!')
                : Column(
                    children: [
                      Expanded(child: _CartCard()),
                      _CartCheckout(),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
