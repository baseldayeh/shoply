import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_dialog/pro_dialog.dart';
import 'package:shoply_app/core/local/local_storage_user.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/utils/images/app_images.dart';
import 'package:shoply_app/core/utils/theme/app_colors.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/core/utils/widgets/cached_image_network/custom_cached_image_network.dart';
import 'package:shoply_app/core/utils/widgets/dialog/custom_dialog.dart';
import 'package:shoply_app/core/utils/widgets/list_tile/custom_list_tile.dart';
import 'package:shoply_app/features/main/view_model/cubit.dart';
import 'package:shoply_app/features/main/view_model/state.dart';
part 'widgets/bottom_nav_bar/main_bottom_nav_bar.dart';
part 'widgets/drawer/main_drawer.dart';
part 'widgets/app_bar/main_app_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: Scaffold(
        appBar: _MainAppBar(),
        drawer: _MainDrawer(),
        bottomNavigationBar: _MainBottomNavBar(),
        body: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            final cubit = context.read<MainCubit>();

            return cubit.page[cubit.navBarIndex];
          },
        ),
      ),
    );
  }
}
