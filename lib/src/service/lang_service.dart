import 'package:battery_todo/src/repository/setting_repository.dart';
import 'package:battery_todo/util/helper/intl_helper.dart';
import 'package:flutter/material.dart';

class LangService with ChangeNotifier {
  LangService({
    required this.settingRepository,
    Locale? locale,
  }) : locale = locale ?? IntlHelper.en {
    loadLang();
  }

  final SettingRepository settingRepository;

  /// 현재 언어
  Locale locale;

  Future<void> loadLang() async {
    final localeCode = settingRepository.getLocale();
    if (localeCode == 'en') {
      locale = IntlHelper.en;
    } else {
      locale = IntlHelper.ko;
    }
    notifyListeners();
  }

  /// 언어 변경
  void toggleLang() {
    locale = IntlHelper.isKo ? IntlHelper.en : IntlHelper.ko;
    print(locale.languageCode);
    settingRepository.setLocale(locale.languageCode);
    notifyListeners();
  }
}
