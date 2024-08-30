import 'package:battery_todo/src/model/todo/todo.dart';
import 'package:battery_todo/src/service/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodoContainer extends StatelessWidget {
  final Todo todo;
  final Function() onDoubleTap;
  final Function() onDismissed;

  const TodoContainer({
    super.key,
    required this.todo,
    required this.onDoubleTap,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      movementDuration: Duration(milliseconds: 300),
      onDismissed: (dismissDirection) => onDismissed(),
      direction: DismissDirection.horizontal,
      background: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: context.color.primary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Container(
            width: 5.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: context.color.primary,
            ),
          ),
        ],
      ),
      secondaryBackground: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.color.secondary,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Container(
            width: 5.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: context.color.secondary,
            ),
          ),
        ],
      ),
      key: Key(todo.id.toString()),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onDoubleTap: onDoubleTap,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300.w),
                  decoration: BoxDecoration(
                    color: todo.priority
                        ? context.color.secondary
                        : context.color.tertiary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: Text(
                      todo.title,
                      style: context.typo.subtitle1
                          .copyWith(fontWeight: context.typo.semiBold),

                      maxLines: null, // 줄 수 제한 없음
                      overflow: TextOverflow.visible, // 텍스트 오버플로우를 보여줌
                    ),
                  ),
                ),
              ),
              Container(
                width: 5.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: todo.priority
                      ? context.color.secondary
                      : context.color.tertiary,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
