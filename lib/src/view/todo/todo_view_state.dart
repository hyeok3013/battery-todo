import 'package:battery_todo/src/model/todo/todo.dart';
import 'package:battery_todo/src/view/base_view_state.dart';

class TodoViewState extends BaseViewState {
  const TodoViewState({
    required this.todos,
    required this.isFull,
  });

  final List<Todo> todos;
  final bool isFull;

  TodoViewState copyWith({List<Todo>? todos, bool? isFull}) {
    return TodoViewState(
      todos: todos ?? this.todos,
      isFull: isFull ?? this.isFull,
    );
  }
}
