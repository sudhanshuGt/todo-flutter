import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../model/todo_model.dart';

/// Remote data source for fetching and modifying todos via REST API.
///
/// Uses [Dio] for making HTTP requests. Returns data layer models ([TodoModel])
/// which are later converted to domain entities in the repository layer.
class TodoRemoteDatasource {
  final Dio dio;

  /// Creates a new instance with the given [dio] HTTP client.
  TodoRemoteDatasource(this.dio);

  /// Fetches the list of todos from the remote API.
  ///
  /// Returns a list of [TodoModel] parsed from JSON.
  /// Throws [DioError] if the network call fails.
  Future<List<TodoModel>> getTodos() async {
    final res = await dio.get(ApiConstants.todos);
    return (res.data as List)
        .map((e) => TodoModel.fromJson(e))
        .toList();
  }

  /// Adds a new todo with the given [text].
  ///
  /// Returns the created [TodoModel] parsed from JSON.
  /// Sets `completed` to `false` by default for new todos.
  Future<TodoModel> addTodo(String text) async {
    final res = await dio.post(
      ApiConstants.todos,
      data: {'todo': text, 'completed': false},
    );
    return TodoModel.fromJson(res.data);
  }

  /// Updates an existing todo represented by [m].
  ///
  /// Sends a PUT request to update the todo and returns the updated [TodoModel].
  Future<TodoModel> updateTodo(TodoModel m) async {
    final res = await dio.put(
      '${ApiConstants.todos}/${m.id}',
      data: m.toJson(),
    );
    return TodoModel.fromJson(res.data);
  }

  /// Deletes a todo by its [id].
  ///
  /// Sends a DELETE request to the API. Does not return any data.
  Future<void> deleteTodo(int id) async {
    await dio.delete('${ApiConstants.todos}/$id');
  }
}
