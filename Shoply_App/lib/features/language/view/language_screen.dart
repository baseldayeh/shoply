import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/localization/locale_keys.g.dart';
import 'package:shoply_app/core/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:shoply_app/features/language/view_model/cubit.dart';
import 'package:shoply_app/features/language/view_model/state.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(titleText: LocaleKeys.Language_language.tr()),
      body: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          final cubit = context.read<LanguageCubit>();
          return Column(
            spacing: 10,
            children: [
              SizedBox(height: 5),
              RadioGroup(
                groupValue: cubit.locale,
                onChanged: (value) {
                  cubit.changeLanguage(
                    langCode: value ?? Locale('en'),
                    context: context,
                  );
                },
                child: RadioListTile(
                  value: Locale('en'),
                  title: Text(
                    LocaleKeys.Language_english.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                  ),
                ),
              ),
              RadioGroup(
                groupValue: cubit.locale,
                onChanged: (value) {
                  cubit.changeLanguage(
                    langCode: value ?? Locale('ar'),
                    context: context,
                  );
                },
                child: RadioListTile(
                  value: Locale('ar'),
                  title: Text(
                    LocaleKeys.Language_arabic.tr(),
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
