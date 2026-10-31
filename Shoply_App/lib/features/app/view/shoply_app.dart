import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/routes/app_pages.dart';
import 'package:shoply_app/core/routes/app_routes.dart';
import 'package:shoply_app/core/utils/theme/app_theme.dart';
import 'package:shoply_app/features/language/view_model/cubit.dart';
import 'package:shoply_app/features/theme/view_model/cubit.dart';

class ShoplyApp extends StatelessWidget {
  const ShoplyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()..initTheme()),
        BlocProvider(
          create: (_) => LanguageCubit()..initLanguage(context: context),
        ),
      ],
      child: Builder(
        builder: (context) {
          final cubitTheme = context.watch<ThemeCubit>();
          final cubitLang = context.watch<LanguageCubit>();

          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: cubitLang.locale,
            title: 'Shoply App',
            onGenerateRoute: AppRoutes.onGenerateRoute,
            initialRoute: AppPages.splashScreen,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.themeLight,
            darkTheme: AppTheme.themeDark,
            themeMode: cubitTheme.themeMode,
          );
        },
      ),
    );
  }
}
