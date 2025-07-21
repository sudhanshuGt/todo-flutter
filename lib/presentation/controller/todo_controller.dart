import 'package:get/get.dart';
import '../../core/error/failure.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/add_todo_usecase.dart';
import '../../domain/usecases/get_todo_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';

/// Controller that manages all todo-related operations.
///
/// Uses GetX for state management and communicates exclusively
/// with domain layer use cases (clean architecture).
class TodoController extends GetxController {
  final GetTodosUsecase getTodos;       // Fetches the list of todos
  final AddTodoUsecase addTodo;         // Adds a new todo
  final UpdateTodoUsecase updateTodo;   // Updates an existing todo
  final DeleteTodoUsecase deleteTodo;   // Deletes a todo by ID

  TodoController(
      this.getTodos,
      this.addTodo,
      this.updateTodo,
      this.deleteTodo,
      );

  /// Observables for UI state
  final todos   = <Todo>[].obs;        // Reactive list of todos displayed in the UI
  final loading = false.obs;           // Indicates if a fetch operation is ongoing
  final error   = Rxn<String>();       // Holds the latest error message, if any

  /// Called automatically when the controller is initialized.
  /// Triggers fetching todos immediately after creation.
  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  /// Fetches all todos and updates the observable [todos] list.
  ///
  /// Handles loading and error states to update the UI accordingly.
  Future<void> fetchTodos() async {
    loading.value = true;
    error.value   = null;

    try {
      todos.value = await getTodos(); // Retrieve todos from use case
    } on Failure catch (f) {
      error.value = f.message; // Capture and display error message
    } finally {
      loading.value = false;
    }
  }

  /// Adds a new todo with the provided [text] and appends it to the list.
  Future<void> add(String text) async {
    final t = await addTodo(text);
    todos.add(t); // Reactive list updates UI automatically
  }

  /// Toggles the completion status of [t] and updates it in the list.
  Future<void> toggleComplete(Todo t) async {
    final updated = await updateTodo(t); // Perform update in domain layer
    final idx = todos.indexWhere((e) => e.id == updated.id);
    if (idx != -1) todos[idx] = updated; // Replace with updated todo
  }

  /// Deletes todo [t] both from the data source and the observable list.
  Future<void> remove(Todo t) async {
    await deleteTodo(t.id); // Remove from data source
    todos.removeWhere((e) => e.id == t.id); // Update UI list
  }
}
