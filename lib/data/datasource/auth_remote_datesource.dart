import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../model/auth_response_model.dart';
 
class AuthRemoteDatasource {
  final Dio dio;
  AuthRemoteDatasource(this.dio);

  Future<AuthResponseModel> signUp(
      {required String name,
        required String email,
        required String password}) async {
    final res = await dio.post(ApiConstants.signUp,
        data: {'name': name, 'email': email, 'password': password});
    return AuthResponseModel.fromJson(res.data);
  }

  Future<AuthResponseModel> login(
      {required String email, required String password}) async {
    final res =
    await dio.post(ApiConstants.login, data: {'email': email, 'password': password});
    return AuthResponseModel.fromJson(res.data);
  }
}
