/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:wash_your_cloth_mobile_app/data/local/local_storage_service.dart';

import 'client_constant.dart';
import 'client_interceptor.dart';

class Client {
  late Dio request;
  final LocalStorageService localStorageService;

  final BaseOptions options = BaseOptions(
    baseUrl: ClientConstant.baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 1000),
    validateStatus: (status) {
      return status != null && status < 700;
    },
  );

  Client({required this.localStorageService}) {
    request = Dio(options);
    request.interceptors.add(ClientInterceptor(localStorageService: localStorageService));
  }
}