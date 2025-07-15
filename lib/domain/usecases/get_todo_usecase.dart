import '../repositories/todo_repository.dart';
import '../entities/todo.dart';

class GetTodosUsecase {
  final TodoRepository repo;
  GetTodosUsecase(this.repo);
  Future<List<Todo>> call() => repo.getTodos();
}
