import '../repositories/todo_repository.dart';
import '../entities/todo.dart';

class AddTodoUsecase {
  final TodoRepository repo;
  AddTodoUsecase(this.repo);
  Future<Todo> call(String text) => repo.addTodo(text);
}
