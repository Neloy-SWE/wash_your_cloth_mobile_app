/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:wash_your_cloth_mobile_app/data/client/client_constant.dart';
import 'package:wash_your_cloth_mobile_app/data/local/local_storage_service.dart';

import '../model/model_login.dart';
import '../network/api_path.dart';

class ClientInterceptor extends Interceptor {
  final LocalStorageService _localStorageService;

  static const List<String> _openPaths = [ApiPath.login, ApiPath.refreshToken];
  final Dio _refreshDio = Dio(BaseOptions(baseUrl: ClientConstant.baseUrl));

  ClientInterceptor({required LocalStorageService localStorageService})
    : _localStorageService = localStorageService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_openPaths.contains(options.path)) {
      final token = await _localStorageService.getToken();
      if (token != null) {
        options.headers[ClientConstant.authorization] =
            '${ClientConstant.bearer} $token';
      }
    }

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
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == ClientConstant.statusCode401Unauthorized &&
        !_openPaths.contains(err.requestOptions.path)) {
      final currentRefreshToken = await _localStorageService.getRefreshToken();

      if (currentRefreshToken != null) {
        try {
          final response = await _refreshDio.post(
            ApiPath.refreshToken,
            data: {ClientConstant.refreshToken: currentRefreshToken},
          );

          if (response.statusCode == ClientConstant.statusCode200OK) {
            final data = response.data;

            await _localStorageService.saveAuthData(
              modelLogin: ModelLogin.fromJson(data),
            );

            final requestOptions = err.requestOptions;
            final dynamic newToken = data[ClientConstant.token];
            requestOptions.headers[ClientConstant.authorization] =
                '${ClientConstant.bearer} $newToken';

            final clonedResponse = await _refreshDio.fetch(requestOptions);
            return handler.resolve(clonedResponse);
          }
        } catch (_) {
          await _localStorageService.clearAuthData();
        }
      }
    }

    log("\n\n\nError: $err\n\n\n");
    super.onError(err, handler);
  }

  // Future<void> refreshToken(
  //   RequestOptions options,
  //   RequestInterceptorHandler handler,
  // ) async {
  //   String status = await localStorageService.authorizeStatus(
  //     positiveStatus: ClientConstant.validToken,
  //     negativeStatus: ClientConstant.logout,
  //     tokenStatus: ClientConstant.updateToken,
  //   );
  //   if (status == ClientConstant.updateToken) {
  //     String? currentRefreshToken = await localStorageService.getRefreshToken();
  //     Map<String, dynamic> data = {
  //       ClientConstant.refreshToken: currentRefreshToken,
  //     };
  //     var (modelLogin, modelError) = await apiRefreshToken.refreshToken(
  //       data: data,
  //     );
  //     if (modelError == null) {}
  //   }
  //
  //   // ModelLogin modelLogin = await apiRefreshToken.refreshToken(data: data)
  // }
}
