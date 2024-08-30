import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class IntlHelper {
  /// 지원 언어
  static const Locale en = Locale('en');
  static const Locale ko = Locale('ko');

  /// 한국어 여부
  static bool get isKo => Intl.getCurrentLocale() == ko.languageCode;

  static String extractTime(String dateTimeString) {
    // 날짜와 시간을 분리
    String timePart = dateTimeString.split(' ')[1];
    // 시간 부분만 추출
    String time = timePart.split(':').take(2).join(':');
    return time;
  }
}
