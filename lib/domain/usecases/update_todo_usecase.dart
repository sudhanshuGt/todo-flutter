import '../repositories/todo_repository.dart';
import '../entities/todo.dart';

class UpdateTodoUsecase {
  final TodoRepository repo;
  UpdateTodoUsecase(this.repo);
  Future<Todo> call(Todo todo) => repo.updateTodo(todo);
}
