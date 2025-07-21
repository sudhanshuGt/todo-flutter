import 'package:dio/dio.dart';
import 'package:myapp/core/network/token_intercepter.dart';

import '../constants/api_constants.dart';

/* A singleton class that manages Dio HTTP client configuration
 including base URL, timeouts, and interceptors. */

class DioClient {
  /* Private constructor for singleton pattern. */
  DioClient._();

  /// The single shared instance of [DioClient].
  static final DioClient _instance = DioClient._();

  /// Factory constructor that always returns the same instance.
  factory DioClient() => _instance;

  /// The Dio instance used for making HTTP requests.
  late final Dio dio;

  /* Initializes Dio with base options and interceptors.
  Should be called once at app startup before making any network requests. */
  Future<void> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
      ),
    );

    ///  interceptor for attaching authentication tokens.
    dio.interceptors.add(TokenInterceptor());

    /// Add log interceptor for debugging network calls.
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        logPrint: (obj) => print("🔐 $obj"), // Custom log format
      ),
    );
  }
}
