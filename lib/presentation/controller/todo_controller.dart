import 'package:get/get.dart';
import '../../core/error/failure.dart';
import '../../domain/entities/todo.dart';
 import '../../domain/usecases/add_todo_usecase.dart';
import '../../domain/usecases/get_todo_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';

class TodoController extends GetxController {
  final GetTodosUsecase getTodos;
  final AddTodoUsecase addTodo;
  final UpdateTodoUsecase updateTodo;
  final DeleteTodoUsecase deleteTodo;

  TodoController(this.getTodos, this.addTodo, this.updateTodo, this.deleteTodo);

  final todos   = <Todo>[].obs;
  final loading = false.obs;
  final error   = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    loading.value = true;
    error.value   = null;
    try {
      todos.value = await getTodos();
    } on Failure catch (f) {
      error.value = f.message;
    } finally {
      loading.value = false;
    }
  }

  Future<void> add(String text) async {
    final t = await addTodo(text);
    todos.add(t);
  }

  Future<void> toggleComplete(Todo t) async {
    final updated = await updateTodo(t);
    final idx = todos.indexWhere((e) => e.id == updated.id);
    if (idx != -1) todos[idx] = updated;
  }

  Future<void> remove(Todo t) async {
    await deleteTodo(t.id);
    todos.removeWhere((e) => e.id == t.id);
  }
}
