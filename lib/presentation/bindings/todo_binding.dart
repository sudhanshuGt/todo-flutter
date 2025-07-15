import 'package:get/get.dart';

import '../../di/service_locator.dart';
import '../../domain/usecases/add_todo_usecase.dart';
import '../../domain/usecases/delete_todo_usecase.dart';
import '../../domain/usecases/get_todo_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';
import '../controller/todo_controller.dart';



class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoController(
      sl<GetTodosUsecase>(),
      sl<AddTodoUsecase>(),
      sl<UpdateTodoUsecase>(),
      sl<DeleteTodoUsecase>(),
    ));
  }
}
