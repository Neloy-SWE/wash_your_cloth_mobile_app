/* 
Created by Neloy on 03 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_path.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_service_activation.dart';

abstract class IApiServiceActivation {
  Future<(ModelServiceActivation?, ModelError?)> serviceActivation({
    required String serviceId,
  });
}

class ApiServiceActivation implements IApiServiceActivation {
  final Client client;

  const ApiServiceActivation({required this.client});

  @override
  Future<(ModelServiceActivation?, ModelError?)> serviceActivation({
    required String serviceId,
  }) async {
    try {
      Response response = await client.request.patch(
        ApiPath.serviceActivation + serviceId,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelServiceActivation activation = ModelServiceActivation.fromJson(
          response.data,
        );
        return (activation, null);
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
