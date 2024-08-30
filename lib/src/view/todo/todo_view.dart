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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  late TodoViewModel todoViewModel;

  @override
  void initState() {
    super.initState();
    todoViewModel = TodoViewModel(
      todoRepository: TodoRepository(),
      settingRepository: context.settingRepository,
      batteryService: context.read<BatteryService>(),
    );
    todoViewModel.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: todoViewModel,
      builder: (BuildContext context, TodoViewModel viewModel) => HideKeyboard(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: viewModel.isFull
                  ? context.color.primary
                  : context.color.secondary,
              title: Text(
                '${viewModel.isFull ? 'On' : 'Off'} 100%',
                style: context.typo.headline1.copyWith(
                    fontWeight: context.typo.semiBold,
                    color: viewModel.isFull
                        ? context.color.onPrimary
                        : context.color.onSecondary),
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
                    itemCount: viewModel.getItemCount(viewModel.todos),
                    itemBuilder: (context, index) {
                      final item =
                          viewModel.getItemAtIndex(viewModel.todos, index);
                      if (item is String) {
                        ///헤더부분
                        return Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 16.w),
                                color: context.color.hint,
                                alignment: Alignment.center,
                                child: Text(
                                  item,
                                  style: context.typo.headline6,
                                ),
                              ),
                            ),
                            Container(
                              width: 5.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                color: context.color.hint,
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
                              context
                                  .read<NotificationService>()
                                  .updateBadgeNumber(viewModel.todos.length);
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

                    context
                        .read<NotificationService>()
                        .updateBadgeNumber(viewModel.todos.length);

                    viewModel.textEditingController.clear();
                    viewModel.batteryService.updateIsFull();
                  },
                  controller: viewModel.textEditingController,
                  isFull: viewModel.isFull,
                  hint: viewModel.isFull
                      ? S.current.enableHintText
                      : S.current.disableHintText,
                ),
              ],
            )),
      ),
    );
  }
}
