/* 
Created by Neloy on 12 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../client/client.dart';
import '../../../../client/client_constant.dart';
import '../../../../model/model_error.dart';
import '../../../../model/model_profile_update_user.dart';
import '../../../api_path.dart';

abstract class IApiProfileUpdateUser {
  Future<(ModelProfileUpdateUser?, ModelError?)> updateProfile({
    required Map<String, dynamic> data,
  });
}

class ApiProfileUpdateUser implements IApiProfileUpdateUser {
  final Client client;

  const ApiProfileUpdateUser({required this.client});

  @override
  Future<(ModelProfileUpdateUser?, ModelError?)> updateProfile({
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await client.request.patch(
        ApiPath.updateUser,
        data: data,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelProfileUpdateUser result = ModelProfileUpdateUser.fromJson(
          response.data,
        );
        return (result, null);
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
