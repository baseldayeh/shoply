import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/features/products/view_model/cubit.dart';
import 'package:shoply_app/features/products/view_model/state.dart';
part 'widgets/products_grid.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
    super.key,
    required this.titleText,
    required this.categoryId,
  });
  final String titleText;
  final String categoryId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit()..getProducts(categoryId: categoryId),
      child: Scaffold(
        appBar: CustomAppBar(titleText: titleText),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            final cubit = context.read<ProductsCubit>();
            if (state is ProductsLoadingState) {
              return CustomLoadingData();
            } else if (state is ProductsErrorState) {
              return Center(child: Text(state.errorMessage));
            }
            return CustomRefreshIndicator(
              onRefresh: () async {
                await cubit.refreshProducts(categoryId: categoryId);
              },
              child: _ProductsGrid(),
            );
          },
        ),
      ),
    );
  }
}
