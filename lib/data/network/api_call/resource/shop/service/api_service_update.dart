/* 
Created by Neloy on 11 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_service_update.dart';
import '../../../../api_path.dart';

abstract class IApiServiceUpdate {
  Future<(ModelServiceUpdate?, ModelError?)> serviceUpdate({
    required Map<String, dynamic> data,
    required String serviceId,
  });
}

class ApiServiceUpdate implements IApiServiceUpdate {
  final Client client;

  const ApiServiceUpdate({required this.client});

  @override
  Future<(ModelServiceUpdate?, ModelError?)> serviceUpdate({
    required Map<String, dynamic> data,
    required String serviceId,
  }) async {
    try {
      Response response = await client.request.patch(
        ApiPath.serviceUpdate + serviceId,
        data: data,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelServiceUpdate serviceUpdate = ModelServiceUpdate.fromJson(
          response.data,
        );
        return (serviceUpdate, null);
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
