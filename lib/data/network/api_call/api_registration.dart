/* 
Created by Neloy on 11 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:wash_your_cloth_mobile_app/data/client/client_constant.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_error.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_login_unverified.dart';

import '../../client/client.dart';
import '../api_path.dart';

abstract class IApiRegistration {
  Future<(ModelLoginUnverified?, ModelError?)> registration({
    required Map<String, dynamic> data,
  });
}

class ApiRegistration implements IApiRegistration {
  final Client client;

  const ApiRegistration({required this.client});

  @override
  Future<(ModelLoginUnverified?, ModelError?)> registration({
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await client.request.post(
        ApiPath.registration,
        data: data,
      );

      if (response.statusCode == ClientConstant.statusCode201Created) {
        ModelLoginUnverified modelLoginUnverified =
            ModelLoginUnverified.fromJson(response.data);

        return (modelLoginUnverified, null);
      } else {
        ModelError modelError = ModelError.fromJson(response.data);
        return (null, modelError);
      }
    } catch (e) {
      ModelError modelError = ModelError(error: []);
      return (null, modelError);
    }
  }
}
