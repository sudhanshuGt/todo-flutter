import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../model/todo_model.dart';

class TodoRemoteDatasource {
  final Dio dio;
  TodoRemoteDatasource(this.dio);

  Future<List<TodoModel>> getTodos() async {
    final res = await dio.get(ApiConstants.todos);
    return (res.data as List).map((e) => TodoModel.fromJson(e)).toList();
  }

  Future<TodoModel> addTodo(String text) async {
    final res = await dio.post(ApiConstants.todos,
        data: {'todo': text, 'completed': false});
    return TodoModel.fromJson(res.data);
  }

  Future<TodoModel> updateTodo(TodoModel m) async {
    final res = await dio.put('${ApiConstants.todos}/${m.id}', data: m.toJson());
    return TodoModel.fromJson(res.data);
  }

  Future<void> deleteTodo(int id) async {
    await dio.delete('${ApiConstants.todos}/$id');
  }
}
