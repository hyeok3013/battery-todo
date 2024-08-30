import 'package:battery_todo/src/repository/setting_repository.dart';
import 'package:battery_todo/src/repository/todo_repository.dart';
import 'package:battery_todo/src/service/battery_service.dart';
import 'package:battery_todo/src/service/lang_service.dart';
import 'package:battery_todo/src/service/notification_service.dart';
import 'package:battery_todo/src/service/theme_service.dart';
import 'package:battery_todo/src/view/todo/todo_view.dart';
import 'package:battery_todo/util/helper/shared_preferences_helper.dart';
import 'package:battery_todo/util/lang/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final todoRepository = TodoRepository();
  await todoRepository.initialize(); // Isar 초기화
  tz.initializeTimeZones();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        todoRepositoryProvider.overrideWithValue(todoRepository),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: ref.themeService.themeData,
          locale: ref.watch(langServiceProvider),
          themeMode:
              ref.watch(themeServiceProvider).brightness == Brightness.light
                  ? ThemeMode.light
                  : ThemeMode.dark,
          home: TodoView(),
        );
      },
    );
  }
}
