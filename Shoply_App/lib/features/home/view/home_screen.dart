import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/images/app_images.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_app/core/utils/widgets/loading/custom_loading_data.dart';
import 'package:shoply_app/core/utils/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:shoply_app/core/utils/widgets/view_all/custom_view_all.dart';
import 'package:shoply_app/features/home/view_model/cubit.dart';
import 'package:shoply_app/features/home/view_model/state.dart';
part 'widgets/home_sales.dart';
part 'widgets/home_categories.dart';
part 'widgets/home_trending_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHome(),
      child: Center(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cubit = context.read<HomeCubit>();
            if (state is HomeLoadingState) {
              return CustomLoadingData();
            } else if (state is HomeErrorState) {
              return Center(child: Text(state.errorMessage));
            }
            return CustomRefreshIndicator(
              onRefresh: () async {
                await cubit.refreshData();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _HomeSales(),
                    SizedBox(height: 20),
                    _HomeCategories(),
                    SizedBox(height: 20),
                    _HomeTrendingProducts(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
