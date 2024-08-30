import 'package:battery_todo/src/repository/setting_repository.dart';
import 'package:battery_todo/theme/dart_theme.dart';
import 'package:battery_todo/theme/foundation/app_theme.dart';
import 'package:battery_todo/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

final themeServiceProvider =
    NotifierProvider<ThemeService, AppTheme>(ThemeService.new);

class ThemeService extends Notifier<AppTheme> {
  @override
  AppTheme build() => LightTheme();

  SettingRepository get settingRepository =>
      ref.read(settingRepositoryProvider);

  Future<void> loadTheme() async {
    final themeName = settingRepository.getTheme();
    if (themeName == 'dark') {
      state = DarkTheme();
      // print(themeName);
    } else {
      state = LightTheme();
      // print(themeName);
    }
  }

  /// 테마 변경
  void toggleTheme() {
    if (state.brightness == Brightness.light) {
      state = DarkTheme();
      settingRepository.setTheme(state.brightness.name);
    } else {
      state = LightTheme();
      settingRepository.setTheme(state.brightness.name);
    }
  }

  /// Material ThemeData 커스텀
  ThemeData get themeData {
    return ThemeData(
      /// Scaffold
      scaffoldBackgroundColor: state.color.hintContainer,

      /// AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: state.color.surface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: state.color.text,
        ),
        titleTextStyle: state.typo.headline2.copyWith(
          color: state.color.text,
        ),
      ),
    );
  }
}

extension ThemeServiceExt on WidgetRef {
  ThemeService get themeService => watch(themeServiceProvider.notifier);
  AppTheme get theme => watch(themeServiceProvider);
  AppColor get color => theme.color;
  AppDeco get deco => theme.deco;
  AppTypo get typo => theme.typo;
}
