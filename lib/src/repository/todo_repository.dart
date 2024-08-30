import 'package:battery_todo/src/model/todo/todo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class TodoRepository {
  late Isar isar;

  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TodoSchema],
      directory: dir.path,
    );
  }

  Future<List<Todo>> getTodos() async {
    return await isar.todos.where().findAll();
  }

  Future<void> addTodo(Todo todo) async {
    await isar.writeTxn(() async {
      await isar.todos.put(todo);
    });
  }

  Future<void> updateTodoPriority(Todo todo, bool priority) async {
    todo.priority = priority;
    await isar.writeTxn(() async {
      await isar.todos.put(todo);
    });
  }

  Future<void> deleteTodo(Todo todo) async {
    await isar.writeTxn(() async {
      await isar.todos.delete(todo.id);
    });
  }
}
