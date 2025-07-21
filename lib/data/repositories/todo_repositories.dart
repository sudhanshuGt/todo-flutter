import 'package:myapp/data/mapper/todo_mapper.dart';

import '../../core/error/exceptions.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasource/todo_remote_datasource.dart';
import '../model/todo_model.dart';

/// Implementation of [TodoRepository] that communicates with the remote data source.
///
/// Converts between data layer models ([TodoModel]) and domain layer entities ([Todo]).
class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDatasource remote;

  /// Creates an instance with the required [TodoRemoteDatasource].
  TodoRepositoryImpl(this.remote);

  /// Retrieves all todos from the remote API.
  ///
  /// Returns a list of [Todo] entities mapped from [TodoModel].
  /// Throws [ServerException] if a network or server error occurs.
  @override
  Future<List<Todo>> getTodos() async {
    try {
      return (await remote.getTodos())
          .map((e) => e.toEntity()) // Map each data model to domain entity
          .toList();
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// Adds a new todo with the given [text].
  ///
  /// Returns the created [Todo] entity.
  /// Throws [ServerException] if a network or server error occurs.
  @override
  Future<Todo> addTodo(String text) async {
    try {
      return (await remote.addTodo(text)).toEntity();
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// Updates an existing [todo].
  ///
  /// Converts the [Todo] entity to a [TodoModel] before making the remote call.
  /// Returns the updated [Todo] entity.
  /// Throws [ServerException] if a network or server error occurs.
  @override
  Future<Todo> updateTodo(Todo todo) async {
    try {
      return (await remote.updateTodo(
        TodoModel(
          id: todo.id,
          todo: todo.todo,
          completed: todo.completed,
        ),
      ))
          .toEntity();
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// Deletes the todo with the specified [id].
  ///
  /// Throws [ServerException] if a network or server error occurs.
  @override
  Future<void> deleteTodo(int id) async {
    try {
      await remote.deleteTodo(id);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
