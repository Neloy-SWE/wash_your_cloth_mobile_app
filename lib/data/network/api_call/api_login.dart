/* 
Created by Neloy on 01 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../client/client.dart';
import '../../client/client_constant.dart';
import '../../model/model_error.dart';
import '../../model/model_login.dart';
import '../../model/model_login_unverified.dart';
import '../api_path.dart';

abstract class IApiLogin {
  Future<(ModelLogin?, ModelLoginUnverified?, ModelError?)> login({
    required Map<String, dynamic> data,
  });
}

class ApiLogin implements IApiLogin {
  final Client client;

  const ApiLogin({required this.client});

  @override
  login({required Map<String, dynamic> data}) async {
    try {
      Response response = await client.request.post(ApiPath.login, data: data);

      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelLogin modelLogin = ModelLogin.fromJson(response.data);
        return (modelLogin, null, null);
      } else if (response.statusCode == ClientConstant.statusCode202Accepted) {
        ModelLoginUnverified modelLoginUnverified =
            ModelLoginUnverified.fromJson(response.data);
        return (null, modelLoginUnverified, null);
      } else {
        ModelError modelError = ModelError.fromJson(response.data);
        return (null, null, modelError);
      }
    } catch (e) {
      // ModelError modelError = ModelError(error: [ClientConstant.serverError]);
      ModelError modelError = ModelError(error: []);
      return (null, null, modelError);
    }
  }
}
