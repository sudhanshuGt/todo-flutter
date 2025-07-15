import '../entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
  Future<Todo> addTodo(String text);
  Future<Todo> updateTodo(Todo todo);
  Future<void> deleteTodo(int id);
}
