import 'package:battery_todo/src/model/todo/todo.dart';
import 'package:battery_todo/src/view/base_view_state.dart';

class TodoViewState extends BaseViewState {
  const TodoViewState({
    required this.todos,
  });

  final List<Todo> todos;

  TodoViewState copyWith({List<Todo>? todos}) {
    return TodoViewState(todos: todos ?? this.todos);
  }
}
