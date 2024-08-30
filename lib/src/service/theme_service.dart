import 'package:battery_todo/src/repository/setting_repository.dart';
import 'package:battery_todo/theme/dart_theme.dart';
import 'package:battery_todo/theme/foundation/app_theme.dart';
import 'package:battery_todo/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeService with ChangeNotifier {
  ThemeService({
    required this.settingRepository,
    AppTheme? theme,
  }) : theme = theme ?? LightTheme() {
    loadTheme();
  }

  /// 현재 테마
  AppTheme theme;

  final SettingRepository settingRepository;

  Future<void> loadTheme() async {
    final themeName = settingRepository.getTheme();
    if (themeName == 'dark') {
      theme = DarkTheme();
      // print(themeName);
    } else {
      theme = LightTheme();
      // print(themeName);
    }
    notifyListeners();
  }

  /// 테마 변경
  void toggleTheme() {
    if (theme.brightness == Brightness.light) {
      theme = DarkTheme();
      settingRepository.setTheme(theme.brightness.name);
    } else {
      theme = LightTheme();
      settingRepository.setTheme(theme.brightness.name);
    }
    notifyListeners();
  }

  /// Material ThemeData 커스텀
  ThemeData get themeData {
    return ThemeData(
      /// Scaffold
      scaffoldBackgroundColor: theme.color.hintContainer,

      /// AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: theme.color.surface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: theme.color.text,
        ),
        titleTextStyle: theme.typo.headline2.copyWith(
          color: theme.color.text,
        ),
      ),
    );
  }
}

extension ThemeServiceExt on BuildContext {
  ThemeService get themeService => watch<ThemeService>();
  AppTheme get theme => themeService.theme;
  AppColor get color => theme.color;
  AppDeco get deco => theme.deco;
  AppTypo get typo => theme.typo;
}
