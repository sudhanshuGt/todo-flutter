import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/network/dio_cleint.dart';
import '../data/datasource/auth_remote_datesource.dart';
import '../data/datasource/todo_remote_datasource.dart';
import '../data/repositories/auth_repositories_impl.dart';
import '../data/repositories/todo_repositories.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/todo_repository.dart';
import '../domain/usecases/add_todo_usecase.dart';
import '../domain/usecases/delete_todo_usecase.dart';
import '../domain/usecases/get_todo_usecase.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/signup_usecase.dart';
import '../domain/usecases/update_todo_usecase.dart';


final sl = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  await Hive.openBox('authBox');

  final dioClient = DioClient();
  await dioClient.init();
  sl.registerSingleton<Dio>(dioClient.dio);

  sl.registerLazySingleton<AuthRemoteDatasource>(
          () => AuthRemoteDatasource(sl()));
  sl.registerLazySingleton<TodoRemoteDatasource>(
          () => TodoRemoteDatasource(sl()));

   sl.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<TodoRepository>(
          () => TodoRepositoryImpl(sl()));

  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => SignupUsecase(sl()));
  sl.registerLazySingleton(() => GetTodosUsecase(sl()));
  sl.registerLazySingleton(() => AddTodoUsecase(sl()));
  sl.registerLazySingleton(() => UpdateTodoUsecase(sl()));
  sl.registerLazySingleton(() => DeleteTodoUsecase(sl()));
}
