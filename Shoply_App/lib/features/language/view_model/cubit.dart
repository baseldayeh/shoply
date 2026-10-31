import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/local/local_storage.dart';
import 'package:shoply_app/features/language/view_model/state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState.languageInitState);

  Locale? locale;

  void initLanguage({required BuildContext context}) {
    String? lang = LocalStorage.instance.getLanguage();
    if (lang == null) {
      locale = Locale(context.deviceLocale.languageCode);
    } else {
      if (lang == 'en') {
        locale = Locale('en');
      } else {
        locale = Locale('ar');
      }
    }
    emit(LanguageState.languageInitState);
  }

  Future<void> changeLanguage({
    required Locale langCode,
    required BuildContext context,
  }) async {
    context.setLocale(langCode);
    locale = langCode;
    await LocalStorage.instance.setLanguage(languageCode: langCode.toString());
    emit(LanguageState.languageChangeState);
  }
}
