import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/model/cart/cart.dart';
import 'package:shoply_app/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_dialog_error.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_success_dialog.dart';
import 'package:shoply_app/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/features/favourite/view_model/cubit.dart';
import 'package:shoply_app/features/favourite/view_model/state.dart';
part 'widgets/favourite_grid.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteCubit()..getFavourite(),
      child: Scaffold(
        body: BlocConsumer<FavouriteCubit, FavouriteState>(
          listener: (context, state) {
            if (state is FavouriteAddToCartLoadingState) {
              CustomLoading.showDialogLoading(context: context);
            } else if (state is FavouriteAddToCartErrorState) {
              Navigator.pop(context);
              CustomDialogError.showProDialogError(
                context: context,
                title: 'Add to Cart',
                description: state.errorMessage,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            } else if (state is FavouriteAddToCartSuccessState) {
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
            final cubit = context.read<FavouriteCubit>();
            if (state is FavouriteLoadingState) {
              return CustomLoadingData();
            } else if (state is FavouriteErrorState) {
              return Center(child: Text(state.errorMessage));
            }
            return CustomRefreshIndicator(
              onRefresh: () async {
                await cubit.refreshFavourite();
              },
              child: cubit.responseProducts.isEmpty
                  ? EmptyScreen(
                      emptyText: 'Your favourite is empty. Start shopping!',
                    )
                  : _FavouriteGrid(),
            );
          },
        ),
      ),
    );
  }
}
