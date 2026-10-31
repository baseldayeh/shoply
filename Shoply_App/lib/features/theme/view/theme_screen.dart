import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/features/theme/view_model/cubit.dart';
import 'package:shoply_app/features/theme/view_model/state.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Theme'),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final cubit = context.read<ThemeCubit>();
          return Column(
            spacing: 10,
            children: [
              SizedBox(height: 5),
              RadioGroup(
                groupValue: cubit.themeMode,
                onChanged: (value) {
                  cubit.changeTheme(themeMode: value ?? ThemeMode.system);
                },
                child: RadioListTile(
                  value: ThemeMode.system,
                  title: Text(
                    'System',
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                  ),
                ),
              ),
              RadioGroup(
                groupValue: cubit.themeMode,
                onChanged: (value) {
                  cubit.changeTheme(themeMode: value ?? ThemeMode.light);
                },
                child: RadioListTile(
                  value: ThemeMode.light,
                  title: Text(
                    'Light',
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                  ),
                ),
              ),
              RadioGroup(
                groupValue: cubit.themeMode,
                onChanged: (value) {
                  cubit.changeTheme(themeMode: value ?? ThemeMode.dark);
                },
                child: RadioListTile(
                  value: ThemeMode.dark,
                  title: Text(
                    'Dark',
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
