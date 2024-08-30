import 'package:battery_todo/util/helper/shared_preferences_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingRepositoryProvider = Provider<SettingRepository>((ref) {
  return SettingRepository(prefs: ref.read(sharedPreferencesProvider));
});

class SettingRepository {
  final SharedPreferences prefs;

  SettingRepository({required this.prefs});

  // 첫 실행 여부
  Future<void> setFirstLaunch(bool value) async {
    await prefs.setBool('firstLaunch', value);
  }

  bool? getFirstLaunch() {
    return prefs.getBool('firstLaunch');
  }

  // 알람 설정 - 아침
  Future<void> setMorningAlarmTime(String value) async {
    await prefs.setString('morningAlarmTime', value);
  }

  String getMorningAlarmTime() {
    return prefs.getString('morningAlarmTime') ?? '';
  }

  // 알람 설정 - 저녁
  Future<void> setEveningAlarmTime(String value) async {
    await prefs.setString('eveningAlarmTime', value);
  }

  String? getEveningAlarmTime() {
    return prefs.getString('eveningAlarmTime');
  }

  Future<void> setTheme(String value) async {
    await prefs.setString('theme', value);
  }

  String? getTheme() {
    return prefs.getString('theme');
  }

  Future<void> setLocale(String value) async {
    await prefs.setString('locale', value);
  }

  String? getLocale() {
    return prefs.getString('locale');
  }
}
