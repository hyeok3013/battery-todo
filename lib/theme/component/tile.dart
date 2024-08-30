import 'package:battery_todo/src/service/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tile extends ConsumerWidget {
  const Tile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Row(
          children: [
            /// Start Icon
            Icon(
              icon,
              color: ref.color.text,
            ),
            SizedBox(width: 8.w),

            /// Title
            Expanded(
              child: Text(
                title,
                style: ref.typo.headline5,
              ),
            ),

            /// Subtitle
            Text(
              subtitle,
              style: ref.typo.subtitle1.copyWith(
                color: ref.color.primary,
              ),
            ),
            SizedBox(width: 8.w),

            /// End Icon
          ],
        ),
      ),
    );
  }
}
