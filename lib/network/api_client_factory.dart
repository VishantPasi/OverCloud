import 'package:dio/dio.dart';

import 'package:overcloud/services/api_constants.dart';

class ApiClientFactory {
  ApiClientFactory._();

  static Dio create({String? token}){
    final dio = Dio(
      BaseOptions (baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      )
    );

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true
      )
    );

    return dio;
  }

}