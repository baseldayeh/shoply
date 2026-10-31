import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app/core/local/local_storage.dart';
import 'package:shoply_app/features/theme/view_model/state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.system);

  ThemeMode? themeMode;

  void initTheme() {
    String? theme = LocalStorage.instance.getThemeMode();
    if (theme == 'light') {
      themeMode = ThemeMode.light;
      emit(ThemeState.light);
    } else if (theme == 'dark') {
      themeMode = ThemeMode.dark;
      emit(ThemeState.dark);
    } else {
      themeMode = ThemeMode.system;
      emit(ThemeState.system);
    }
  }

  Future<void> changeTheme({required ThemeMode themeMode}) async {
    this.themeMode = themeMode;
    if (themeMode == ThemeMode.dark) {
      emit(ThemeState.dark);
    } else if (themeMode == ThemeMode.light) {
      emit(ThemeState.light);
    } else {
      emit(ThemeState.system);
    }
    await LocalStorage.instance.setTheme(themeMode: themeMode.name);
  }
}
