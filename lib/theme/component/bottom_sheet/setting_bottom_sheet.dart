import 'package:battery_todo/src/service/lang_service.dart';
import 'package:battery_todo/src/service/theme_service.dart';
import 'package:battery_todo/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:battery_todo/theme/component/tile.dart';
import 'package:battery_todo/util/helper/intl_helper.dart';
import 'package:battery_todo/util/lang/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingBottomSheet extends StatelessWidget {
  const SettingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = context.theme.brightness == Brightness.light;
    final LangService langService = context.watch();
    return BaseBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Theme Tile
          Tile(
            icon: isLightTheme
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
            title: S.current.theme,
            subtitle: isLightTheme ? S.current.light : S.current.dark,
            onPressed: context.read<ThemeService>().toggleTheme,
          ),

          /// Lang Tile
          Tile(
            icon: Icons.language_outlined,
            title: S.current.language,
            subtitle: IntlHelper.isKo ? S.current.ko : S.current.en,
            onPressed: langService.toggleLang,
          ),
        ],
      ),
    );
  }
}
