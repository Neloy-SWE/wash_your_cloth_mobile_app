/*
Created by Neloy on 23 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../client/client.dart';
import '../../../client/client_constant.dart';
import '../../../model/model_auth_action.dart';
import '../../../model/model_error.dart';
import '../../api_path.dart';

abstract class IApiLogout {
  Future<(ModelAuthAction?, ModelError?)> logout({
    required Map<String, dynamic> data,
  });
}

class ApiLogout implements IApiLogout {
  final Client client;

  const ApiLogout({required this.client});

  @override
  Future<(ModelAuthAction?, ModelError?)> logout({
    required Map<String, dynamic> data,
  }) async {
    try {
      final Response response = await client.request.post(
        ApiPath.logout,
        data: data,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        return (ModelAuthAction.fromJson(response.data), null);
      }
      return (null, ModelError.fromJson(response.data));
    } catch (error) {
      return (null, ModelError(error: [ClientConstant.serverError]));
    }
  }
}
