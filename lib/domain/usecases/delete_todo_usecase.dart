import '../repositories/todo_repository.dart';

class DeleteTodoUsecase {
  final TodoRepository repo;
  DeleteTodoUsecase(this.repo);
  Future<void> call(int id) => repo.deleteTodo(id);
}
