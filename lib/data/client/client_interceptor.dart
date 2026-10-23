/*
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:wash_your_cloth_mobile_app/data/client/auth_session_expiry_notifier.dart';
import 'package:wash_your_cloth_mobile_app/data/client/client_constant.dart';
import 'package:wash_your_cloth_mobile_app/data/local/local_storage_service.dart';

import '../model/model_login.dart';
import '../network/api_path.dart';

class ClientInterceptor extends Interceptor {
  final LocalStorageService _localStorageService;
  final AuthSessionExpiryNotifier _authSessionExpiryNotifier;
  Future<void>? _refreshInProgress;

  static const List<String> _openPaths = [
    ApiPath.login,
    ApiPath.refreshToken,
    ApiPath.registration,
  ];
  final Dio _refreshDio = Dio(BaseOptions(baseUrl: ClientConstant.baseUrl));

  ClientInterceptor({
    required LocalStorageService localStorageService,
    required AuthSessionExpiryNotifier authSessionExpiryNotifier,
  }) : _localStorageService = localStorageService,
       _authSessionExpiryNotifier = authSessionExpiryNotifier;

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
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.statusCode == ClientConstant.statusCode401Unauthorized &&
        !_openPaths.contains(response.requestOptions.path)) {
      try {
        final retriedResponse = await _refreshAndRetry(response.requestOptions);
        return handler.resolve(retriedResponse);
      } catch (error) {
        log("Authentication retry failed for ${response.requestOptions.path}");
        return handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            error: error,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    }

    log("\n\n\nResponse: $response\n\n\n");
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    log("\n\n\nError: $err\n\n\n");
    super.onError(err, handler);
  }

  Future<Response<dynamic>> _refreshAndRetry(
    RequestOptions requestOptions,
  ) async {
    final latestAccessToken = await _localStorageService.getToken();
    final sentAuthorization =
        requestOptions.headers[ClientConstant.authorization] as String?;
    if (latestAccessToken != null &&
        sentAuthorization != '${ClientConstant.bearer} $latestAccessToken') {
      return _retryRequest(requestOptions, latestAccessToken);
    }

    await _refreshTokens();
    final newAccessToken = await _localStorageService.getToken();
    if (newAccessToken == null) {
      throw StateError("Access token is missing after refresh");
    }
    return _retryRequest(requestOptions, newAccessToken);
  }

  Future<void> _refreshTokens() async {
    final runningRefresh = _refreshInProgress;
    if (runningRefresh != null) {
      await runningRefresh;
      return;
    }

    final refreshFuture = _performRefresh();
    _refreshInProgress = refreshFuture;
    try {
      await refreshFuture;
    } finally {
      if (identical(_refreshInProgress, refreshFuture)) {
        _refreshInProgress = null;
      }
    }
  }

  Future<void> _performRefresh() async {
    final refreshToken = await _localStorageService.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      await _expireSession();
      throw StateError("Refresh token is missing");
    }

    late final Response<dynamic> response;
    try {
      response = await _refreshDio.post(
        ApiPath.refreshToken,
        data: {ClientConstant.refreshToken: refreshToken},
      );
    } on DioException catch (error) {
      if (error.response?.statusCode ==
          ClientConstant.statusCode401Unauthorized) {
        await _expireSession();
      }
      rethrow;
    }

    if (response.statusCode == ClientConstant.statusCode401Unauthorized) {
      await _expireSession();
      throw StateError("Session refresh was rejected");
    }
    if (response.statusCode != ClientConstant.statusCode200OK) {
      throw StateError("Session refresh failed with ${response.statusCode}");
    }
    await _localStorageService.saveAuthData(
      modelLogin: ModelLogin.fromJson(response.data),
    );
  }

  Future<void> _expireSession() async {
    await _localStorageService.clearAuthData();
    _authSessionExpiryNotifier.notifySessionExpired(
      deferRedirectUntilResultDismissed: true,
    );
  }

  Future<Response<dynamic>> _retryRequest(
    RequestOptions requestOptions,
    String accessToken,
  ) {
    return _refreshDio.fetch(
      requestOptions.copyWith(
        headers: {
          ...requestOptions.headers,
          ClientConstant.authorization: '${ClientConstant.bearer} $accessToken',
        },
      ),
    );
  }
}
