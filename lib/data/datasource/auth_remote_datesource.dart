import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../model/auth_response_model.dart';

/// Remote data source responsible for user authentication API calls.
///
/// Uses [Dio] for HTTP requests and maps API responses to [AuthResponseModel].
class AuthRemoteDatasource {
  final Dio dio;

  /// Creates an instance with the provided [dio] HTTP client.
  AuthRemoteDatasource(this.dio);

  /// Registers a new user by sending a POST request to the signup endpoint.
  ///
  /// Requires [name], [email], and [password] for account creation.
  /// Returns an [AuthResponseModel] containing the authentication token and other data.
  /// Throws [DioError] if the network call fails or the server returns an error.
  Future<AuthResponseModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await dio.post(
      ApiConstants.signUp,
      data: {'name': name, 'email': email, 'password': password},
    );
    return AuthResponseModel.fromJson(res.data);
  }

  /// Logs in an existing user by sending a POST request to the login endpoint.
  ///
  /// Requires [email] and [password].
  /// Returns an [AuthResponseModel] containing the authentication token and other data.
  /// Throws [DioError] if the network call fails or the server returns an error.
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final res = await dio.post(
      ApiConstants.login,
      data: {'email': email, 'password': password},
    );
    return AuthResponseModel.fromJson(res.data);
  }
}
