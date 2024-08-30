import 'package:battery_todo/src/repository/setting_repository.dart';
import 'package:battery_todo/src/service/battery_service.dart';
import 'package:battery_todo/src/service/lang_service.dart';
import 'package:battery_todo/src/service/notification_service.dart';
import 'package:battery_todo/src/service/theme_service.dart';
import 'package:battery_todo/src/view/todo/todo_view.dart';
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
  tz.initializeTimeZones();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
          theme: context.themeService.themeData,
          locale: context.watch<LangService>().locale,
          home: TodoView(),
        );
      },
    );
  }
}
