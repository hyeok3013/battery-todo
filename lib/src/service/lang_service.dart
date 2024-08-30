import 'package:battery_todo/src/repository/setting_repository.dart';
import 'package:battery_todo/util/helper/intl_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final langServiceProvider =
    NotifierProvider<LangService, Locale>(LangService.new);

class LangService extends Notifier<Locale> {
  @override
  Locale build() {
    loadLang();
    return IntlHelper.en;
  }

  SettingRepository get settingRepository =>
      ref.read(settingRepositoryProvider);

  Future<void> loadLang() async {
    final localeCode = settingRepository.getLocale();
    if (localeCode == 'en') {
      state = IntlHelper.en;
    } else {
      state = IntlHelper.ko;
    }
  }

  /// 언어 변경
  void toggleLang() {
    state = IntlHelper.isKo ? IntlHelper.en : IntlHelper.ko;
    settingRepository.setLocale(state.languageCode);
  }
}
