import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final box = await Hive.openBox('authBox');
    final token = box.get('jwtToken');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}