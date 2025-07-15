
import 'package:myapp/data/mapper/todo_mapper.dart';

import '../../core/error/exceptions.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasource/todo_remote_datasource.dart';
import '../model/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDatasource remote;
  TodoRepositoryImpl(this.remote);

  @override
  Future<List<Todo>> getTodos() async {
    try {
      return (await remote.getTodos()).map((e) => e.toEntity()).toList();
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Todo> addTodo(String text) async {
    try {
      return (await remote.addTodo(text)).toEntity();
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Todo> updateTodo(Todo todo) async {
    try {
      return (await remote.updateTodo(TodoModel(
        id: todo.id,
        todo: todo.todo,
        completed: todo.completed,
      )))
          .toEntity();
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    try {
      await remote.deleteTodo(id);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
