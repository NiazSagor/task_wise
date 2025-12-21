import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_wise/core/constants/constants.dart';

class AuthInterceptor extends QueuedInterceptor {
  final SharedPreferences sharedPreferences;

  AuthInterceptor({required this.sharedPreferences});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = sharedPreferences.getString(Constants.tokenKey);
    if (token != null) {
      options.headers['token'] = token;
    }
    debugPrint("AuthInterceptor onRequest finish");
    handler.next(options);
  }
}
