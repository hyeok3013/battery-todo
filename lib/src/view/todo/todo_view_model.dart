import 'package:battery_todo/src/model/todo/todo.dart';
import 'package:battery_todo/src/repository/setting_repository.dart';
import 'package:battery_todo/src/repository/todo_repository.dart';
import 'package:battery_todo/src/service/battery_service.dart';
import 'package:battery_todo/src/view/base_view_model.dart';
import 'package:battery_todo/util/lang/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoViewModel extends BaseViewModel {
  final TodoRepository todoRepository;
  final SettingRepository settingRepository;
  final BatteryService batteryService;
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  List<Todo> todos = [];

  bool get isFull => batteryService.isFull;

  TodoViewModel({
    required this.settingRepository,
    required this.todoRepository,
    required this.batteryService,
  }) {
    batteryService.addListener(onBatteryStateChanged);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();
    batteryService.removeListener(onBatteryStateChanged);
    super.dispose();
  }

  void onBatteryStateChanged() {
    if (batteryService.isFull) {
      print("Battery is full. Managing todos...");
      // 예시: 특정 todo 작업 수행
      // addTodo("Battery is full");
    }
    notifyListeners();
  }

  int getItemCount(List<Todo> todos) {
    final groupedTodos = groupTodosByDate(todos);
    int count = 0;
    groupedTodos.forEach((date, todos) {
      count += todos.length + 1; // 날짜 헤더 + 투두 아이템들
    });
    return count;
  }

  dynamic getItemAtIndex(List<Todo> todos, int index) {
    final groupedTodos = groupTodosByDate(todos);
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
    todos = await todoRepository.getTodos();
    notifyListeners();
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
    ///이 부분 다국어 설정
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
