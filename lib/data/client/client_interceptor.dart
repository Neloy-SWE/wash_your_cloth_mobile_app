/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:developer';

import 'package:dio/dio.dart';

class ClientInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    log(
      "\n\n\nBase URL: ${options.baseUrl}\nAPI Path: ${options.path}\nHeader: ${options.headers}\nBody: ${options.data}\nParameters: ${options.queryParameters}\n\n\n",
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    log("\n\n\nResponse: $response\n\n\n");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("\n\n\nError: $err\n\n\n");
    super.onError(err, handler);
  }
}