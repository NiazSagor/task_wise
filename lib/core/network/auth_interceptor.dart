import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends QueuedInterceptor {
  final SharedPreferences sharedPreferences;
  static const String _tokenKey = 'auth_token';

  AuthInterceptor({required this.sharedPreferences});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = sharedPreferences.getString(_tokenKey);

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
