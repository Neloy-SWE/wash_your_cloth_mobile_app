/* 
Created by Neloy on 12 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_service_add.dart';
import '../../../../api_path.dart';

abstract class IApiServiceAdd {
  Future<(ModelServiceAdd?, ModelError?)> serviceAdd({
    required Map<String, dynamic> data,
  });
}

class ApiServiceAdd implements IApiServiceAdd {
  final Client client;

  const ApiServiceAdd({required this.client});

  @override
  Future<(ModelServiceAdd?, ModelError?)> serviceAdd({
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await client.request.post(
        ApiPath.serviceAdd,
        data: data,
      );
      if (response.statusCode == ClientConstant.statusCode201Created) {
        ModelServiceAdd serviceAdd = ModelServiceAdd.fromJson(response.data);
        return (serviceAdd, null);
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
