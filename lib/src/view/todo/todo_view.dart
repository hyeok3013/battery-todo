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

class TodoView extends ConsumerStatefulWidget {
  const TodoView({super.key});

  @override
  ConsumerState<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends ConsumerState<TodoView> {
  @override
  void initState() {
    super.initState();
    ref.read(todoRepositoryProvider).initialize();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModelProvider: todoViewModelProvider,
      builder: (ref, viewModel, state) => HideKeyboard(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor:
                  viewModel.isFull ? ref.color.primary : ref.color.secondary,
              title: Text(
                '${viewModel.isFull ? 'On' : 'Off'} 100%',
                style: ref.typo.headline1.copyWith(
                    fontWeight: ref.typo.semiBold,
                    color: viewModel.isFull
                        ? ref.color.onPrimary
                        : ref.color.onSecondary),
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
                        ///헤더부분
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
                              context
                                  .read<NotificationService>()
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

                    context
                        .read<NotificationService>()
                        .updateBadgeNumber(state.todos.length);

                    viewModel.textEditingController.clear();
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
