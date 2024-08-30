import 'package:battery_todo/src/model/todo/todo.dart';
import 'package:battery_todo/src/repository/setting_repository.dart';
import 'package:battery_todo/src/repository/todo_repository.dart';
import 'package:battery_todo/src/service/battery_service.dart';
import 'package:battery_todo/src/view/base_view_model.dart';
import 'package:battery_todo/src/view/todo/todo_view_state.dart';
import 'package:battery_todo/util/lang/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TodoViewModel의 Provider 정의
final todoViewModelProvider =
    NotifierProvider.autoDispose<TodoViewModel, TodoViewState>(
  TodoViewModel.new,
);

class TodoViewModel extends BaseViewModel<TodoViewState> {
  late final TodoRepository todoRepository;
  late final SettingRepository settingRepository;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  TodoViewState build() {
    todoRepository = ref.read(todoRepositoryProvider);
    settingRepository = ref.read(settingRepositoryProvider);

    // 배터리 서비스의 상태를 감시
    final batteryState = ref.watch(batteryServiceProvider);

    // 배터리 상태가 변경될 때 onBatteryStateChanged 호출
    if (batteryState?.isFull == true) {
      onBatteryStateChanged();
    }

    // 초기 상태 설정
    return TodoViewState(
      todos: [],
    );
  }

  bool get isFull => ref.watch(batteryServiceProvider)?.isFull ?? false;

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();
  }

  void onBatteryStateChanged() {
    print("Battery is full. Managing todos...");
    // 예시: 특정 todo 작업 수행
    // addTodo("Battery is full");

    // 상태 변경 시 notifyListeners() 대신 상태를 갱신합니다.
    state = state.copyWith(todos: state.todos);
  }

  int getItemCount() {
    final groupedTodos = groupTodosByDate(state.todos);
    int count = 0;
    groupedTodos.forEach((date, todos) {
      count += todos.length + 1; // 날짜 헤더 + 투두 아이템들
    });
    return count;
  }

  dynamic getItemAtIndex(int index) {
    final groupedTodos = groupTodosByDate(state.todos);
    int count = 0;
    for (var date in groupedTodos.keys) {
      if (index == count) {
        return date;
      }
      count++;
      final todosForDate = groupedTodos[date]!;
      if (index < count + todosForDate.length) {
        return todosForDate[index - count];
      }
      count += todosForDate.length;
    }
    return null;
  }

  Map<String, List<Todo>> groupTodosByDate(List<Todo> todos) {
    Map<String, List<Todo>> groupedTodos = {};
    for (var todo in todos) {
      String date = todo.createDate.toString().split(' ')[0]; // 날짜만 추출
      if (groupedTodos.containsKey(date)) {
        groupedTodos[date]!.add(todo);
      } else {
        groupedTodos[date] = [todo];
      }
    }
    return groupedTodos;
  }

  Future<void> initialize() async {
    await todoRepository.initialize();
    await checkFirstLaunch();
    await loadTodos();
  }

  Future<void> loadTodos() async {
    final todos = await todoRepository.getTodos();
    state = state.copyWith(todos: todos);
  }

  Future<void> addTodo(String title) async {
    final newTodo = Todo()
      ..title = title
      ..createDate = DateTime.now()
      ..priority = false;

    await todoRepository.addTodo(newTodo);
    await loadTodos();
  }

  Future<void> updateTodoPriority(Todo todo, bool priority) async {
    await todoRepository.updateTodoPriority(todo, priority);
    await loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await todoRepository.deleteTodo(todo);
    await loadTodos();
  }

  Future<void> checkFirstLaunch() async {
    if (settingRepository.prefs.getBool('isFirstLaunch') ?? true) {
      await onboardingTodo();
      await settingRepository.prefs.setBool('isFirstLaunch', false);
    }
  }

  Future<void> onboardingTodo() async {
    List<Todo> initialTodos = [
      Todo()
        ..title = S.current.onboardingWelcome
        ..createDate = DateTime.now()
        ..priority = false,
      Todo()
        ..title = S.current.onboardingCondition
        ..createDate = DateTime.now()
        ..priority = false,
      Todo()
        ..title = S.current.onboardingDelete
        ..createDate = DateTime.now()
        ..priority = false,
      Todo()
        ..title = S.current.onboardingDone
        ..createDate = DateTime.now()
        ..priority = false,
      Todo()
        ..title = S.current.onboardingImportant
        ..createDate = DateTime.now()
        ..priority = true,
      Todo()
        ..title = S.current.onboardingNotification
        ..createDate = DateTime.now()
        ..priority = false,
    ];

    for (var todo in initialTodos) {
      await todoRepository.addTodo(todo);
    }
    await loadTodos();
  }
}
