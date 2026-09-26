/* 
Created by Neloy on 26 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../client/client.dart';
import '../../../../client/client_constant.dart';
import '../../../../model/model_error.dart';
import '../../../../model/model_profile_update.dart';
import '../../../api_path.dart';

abstract class IApiProfileUpdateShop {
  Future<(ModelProfileUpdate?, ModelError?)> updateProfile({
    required Map<String, dynamic> data,
  });
}

class ApiProfileUpdateShop implements IApiProfileUpdateShop {
  final Client client;

  const ApiProfileUpdateShop({required this.client});

  @override
  Future<(ModelProfileUpdate?, ModelError?)> updateProfile({
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await client.request.patch(
        ApiPath.updateShop,
        data: data,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelProfileUpdate result = ModelProfileUpdate.fromJson(response.data);
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
