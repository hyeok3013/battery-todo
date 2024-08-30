// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enter what you need to do.`
  String get enableHintText {
    return Intl.message(
      'Enter what you need to do.',
      name: 'enableHintText',
      desc: '',
      args: [],
    );
  }

  /// `It needs to be charged.`
  String get disableHintText {
    return Intl.message(
      'It needs to be charged.',
      name: 'disableHintText',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get en {
    return Intl.message(
      'English',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  /// `Korean`
  String get ko {
    return Intl.message(
      'Korean',
      name: 'ko',
      desc: '',
      args: [],
    );
  }

  /// `Welcome! Use this app to manage your tasks effectively. Here’s a quick guide to the main features of the app.`
  String get onboardingWelcome {
    return Intl.message(
      'Welcome! Use this app to manage your tasks effectively. Here’s a quick guide to the main features of the app.',
      name: 'onboardingWelcome',
      desc: '',
      args: [],
    );
  }

  /// `You can only create to-dos when your phone battery is at 100%. Add new tasks when your battery is fully charged!`
  String get onboardingCondition {
    return Intl.message(
      'You can only create to-dos when your phone battery is at 100%. Add new tasks when your battery is fully charged!',
      name: 'onboardingCondition',
      desc: '',
      args: [],
    );
  }

  /// `Swipe left on a to-do to delete it. Easily remove unnecessary items.`
  String get onboardingDelete {
    return Intl.message(
      'Swipe left on a to-do to delete it. Easily remove unnecessary items.',
      name: 'onboardingDelete',
      desc: '',
      args: [],
    );
  }

  /// `Swipe right on a to-do to mark it as done.`
  String get onboardingDone {
    return Intl.message(
      'Swipe right on a to-do to mark it as done.',
      name: 'onboardingDone',
      desc: '',
      args: [],
    );
  }

  /// `Double tap a to-do to mark it as important. Highlight crucial tasks to keep them visible.`
  String get onboardingImportant {
    return Intl.message(
      'Double tap a to-do to mark it as important. Highlight crucial tasks to keep them visible.',
      name: 'onboardingImportant',
      desc: '',
      args: [],
    );
  }

  /// `By allowing notification permissions, you can see your remaining to-dos from the app icon. Enable permissions for easier task management.`
  String get onboardingNotification {
    return Intl.message(
      'By allowing notification permissions, you can see your remaining to-dos from the app icon. Enable permissions for easier task management.',
      name: 'onboardingNotification',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
