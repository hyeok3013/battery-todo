import 'package:battery_todo/src/service/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersistentBottomSheet extends StatefulWidget {
  const PersistentBottomSheet({
    super.key,
    this.hint,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    required this.isFull,
  });

  final String? hint;
  final TextEditingController? controller;
  final void Function(String text)? onChanged;
  final void Function(String text)? onSubmitted;
  final bool isFull;

  @override
  State<PersistentBottomSheet> createState() => _PersistentBottomSheetState();
}

class _PersistentBottomSheetState extends State<PersistentBottomSheet> {
  late final TextEditingController controller =
      widget.controller ?? TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      hasFocus = focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    // 리스너 제거
    focusNode.removeListener(_handleFocusChange);
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 180.h),
      color: context.color.surface,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 24.w, top: 13.h, bottom: 30.h),
                child: TextField(
                  maxLines: null,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  enabled: widget.isFull,
                  focusNode: focusNode,
                  controller: controller,
                  onChanged: (value) {
                    setState(() {});
                    widget.onChanged?.call(value);
                  },
                  onSubmitted: (text) {
                    widget.onSubmitted?.call(text);
                    controller.clear();
                  },
                  style: context.typo.headline5.copyWith(
                    color: context.color.text,
                  ),
                  cursorColor: context.color.primary,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5.w,
                          color: widget.isFull
                              ? context.color.primary
                              : context.color.secondary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 0.5, color: context.color.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.w, color: context.color.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5.w, color: context.color.secondary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    filled: true,
                    fillColor: context.color.hintContainer,
                    hintStyle: context.typo.headline5.copyWith(
                      fontWeight: context.typo.light,
                      color: context.color.onHintContainer,
                    ),
                    hintText: widget.hint,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 11.5.h,
                      horizontal: 16.w,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => widget.onSubmitted!(controller.text),
                      icon: Icon(Icons.battery_charging_full,
                          size: 30,
                          color: widget.isFull
                              ? context.color.primary
                              : context.color.secondary),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 13.w, top: 13.h, bottom: 30.h),
              child: Container(
                width: 9.w,
                height: 20.h,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: hasFocus ? 2.w : 0.5.w,
                      color: widget.isFull
                          ? context.color.primary
                          : context.color.secondary,
                    ),
                    top: BorderSide(
                      width: hasFocus ? 2.w : 0.5.w,
                      color: widget.isFull
                          ? context.color.primary
                          : context.color.secondary,
                    ),
                    right: BorderSide(
                      width: hasFocus ? 2.w : 0.5.w,
                      color: widget.isFull
                          ? context.color.primary
                          : context.color.secondary,
                    ),
                  ),
                  color: context.color.hintContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
