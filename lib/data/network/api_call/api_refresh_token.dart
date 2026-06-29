/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:wash_your_cloth_mobile_app/data/client/client_constant.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_error.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_login.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_path.dart';

import '../../client/client.dart';

abstract class IApiRefreshToken {
  Future<(ModelLogin?, ModelError?)> refreshToken({
    required Map<String, dynamic> data,
  });
}

class ApiRefreshToken implements IApiRefreshToken {
  final Client client;

  ApiRefreshToken({required this.client});

  @override
  Future<(ModelLogin?, ModelError?)> refreshToken({
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await client.request.post(
        ApiPath.refreshToken,
        data: data,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelLogin modelLogin = ModelLogin.fromJson(response.data);
        return (modelLogin, null);
      } else {
        ModelError modelError = ModelError.fromJson(response.data);
        return (null, modelError);
      }
    } catch (e) {
      ModelError modelError = ModelError(error: [ClientConstant.serverError]);
      return (null, modelError);
    }
  }
}
