import 'package:battery_todo/src/model/todo/todo.dart';
import 'package:battery_todo/src/repository/setting_repository.dart';
import 'package:battery_todo/src/repository/todo_repository.dart';
import 'package:battery_todo/src/service/battery_service.dart';
import 'package:battery_todo/src/service/notification_service.dart';
import 'package:battery_todo/src/service/theme_service.dart';
import 'package:battery_todo/src/view/base_view.dart';
import 'package:battery_todo/src/view/setting/setting_view.dart';
import 'package:battery_todo/src/view/todo/todo_view_model.dart';
import 'package:battery_todo/src/view/todo/widget/todo_container.dart';
import 'package:battery_todo/theme/component/bottom_sheet/setting_bottom_sheet.dart';
import 'package:battery_todo/theme/component/hide_keyboard.dart';
import 'package:battery_todo/theme/component/bottom_sheet/persistent_bottom_sheet.dart';
import 'package:battery_todo/util/lang/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModelProvider: todoViewModelProvider,
      builder: (ref, viewModel, state) {
        final isFull = ref.watch(batteryServiceProvider)?.isFull ?? false;

        return HideKeyboard(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: isFull ? ref.color.primary : ref.color.secondary,
              title: Text(
                '${isFull ? 'On' : 'Off'} 100%',
                style: ref.typo.headline1.copyWith(
                  fontWeight: ref.typo.semiBold,
                  color: isFull ? ref.color.onPrimary : ref.color.onSecondary,
                ),
              ),
              titleSpacing: 20.w,
              actions: [
                IconButton(
                  padding: EdgeInsets.only(right: 20.w),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return const SettingBottomSheet();
                      },
                    );
                  },
                  icon: Icon(Icons.menu),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: viewModel.scrollController,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    itemCount: viewModel.getItemCount(),
                    itemBuilder: (context, index) {
                      final item = viewModel.getItemAtIndex(index);
                      if (item is String) {
                        return Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 16.w),
                                color: ref.color.hint,
                                alignment: Alignment.center,
                                child: Text(
                                  item,
                                  style: ref.typo.headline6,
                                ),
                              ),
                            ),
                            Container(
                              width: 5.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                color: ref.color.hint,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15.h, horizontal: 20.w),
                              ),
                            ),
                          ],
                        );
                      } else if (item is Todo) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: TodoContainer(
                            todo: item,
                            onDismissed: () async {
                              await viewModel.deleteTodo(item);
                              ref
                                  .read(notificationServiceProvider)
                                  .updateBadgeNumber(state.todos.length);
                            },
                            onDoubleTap: () {
                              viewModel.updateTodoPriority(
                                  item, !item.priority);
                            },
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
                PersistentBottomSheet(
                  onSubmitted: (text) async {
                    await viewModel.addTodo(text);

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      viewModel.scrollController.animateTo(
                        viewModel.scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    });

                    ref
                        .read(notificationServiceProvider)
                        .updateBadgeNumber(state.todos.length);

                    viewModel.textEditingController.clear();
                  },
                  controller: viewModel.textEditingController,
                  isFull: isFull,
                  hint: isFull
                      ? S.current.enableHintText
                      : S.current.disableHintText,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
