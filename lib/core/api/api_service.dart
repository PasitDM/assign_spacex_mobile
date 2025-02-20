import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_config.dart';

class ApiService {
  Future<Dio> initial() async {
    var options = BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    final dio = Dio(options)..interceptors.add(LogInterceptor(requestBody: kDebugMode, responseBody: kDebugMode));

    return dio;
  }
}
