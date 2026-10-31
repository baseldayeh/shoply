import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/features/categories/view_model/cubit.dart';
import 'package:shoply_app/features/categories/view_model/state.dart';
part 'widgets/categories_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit()..getCategories(),
      child: Scaffold(
        appBar: CustomAppBar(titleText: 'Categories'),
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            final cubit = context.read<CategoriesCubit>();
            if (state is CategoriesLoadingState) {
              return CustomLoadingData();
            } else if (state is CategoriesErrorState) {
              return Center(child: Text(state.errorMessage));
            }
            return CustomRefreshIndicator(
              onRefresh: () async {
                await cubit.refreshCategories();
              },
              child: _CategoriesCard(),
            );
          },
        ),
      ),
    );
  }
}
