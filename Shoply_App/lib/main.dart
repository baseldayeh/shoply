import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shoply_app/core/dependencies/main/main_dependency.dart';
import 'package:shoply_app/features/app/view/shoply_app.dart';

void main() async {
  await MainDependency.mainInitDependency();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: const ShoplyApp(),
    ),
  );
}
