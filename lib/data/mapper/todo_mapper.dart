import '../../domain/entities/todo.dart';
import '../model/todo_model.dart';


extension TodoMapper on TodoModel {
  Todo toEntity() =>
      Todo(id: id, todo: todo, completed: completed);
}
