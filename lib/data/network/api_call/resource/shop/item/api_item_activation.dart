/* 
Created by Neloy on 13 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_path.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_item_activation.dart';

abstract class IApiItemActivation {
  Future<(ModelItemActivation?, ModelError?)> itemActivation({
    required String itemId,
  });
}

class ApiItemActivation implements IApiItemActivation {
  final Client client;

  const ApiItemActivation({required this.client});

  @override
  Future<(ModelItemActivation?, ModelError?)> itemActivation({
    required String itemId,
  }) async {
    try {
      Response response = await client.request.patch(
        ApiPath.itemActivation + itemId,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelItemActivation activation = ModelItemActivation.fromJson(
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
