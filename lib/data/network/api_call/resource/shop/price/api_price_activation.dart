/* 
Created by Neloy on 03 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_path.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_price_activation.dart';

abstract class IApiPriceActivation {
  Future<(ModelPriceActivation?, ModelError?)> priceActivation({
    required String priceId,
  });
}

class ApiPriceActivation implements IApiPriceActivation {
  final Client client;

  const ApiPriceActivation({required this.client});

  @override
  Future<(ModelPriceActivation?, ModelError?)> priceActivation({
    required String priceId,
  }) async {
    try {
      Response response = await client.request.patch(
        ApiPath.priceActivation + priceId,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelPriceActivation activation = ModelPriceActivation.fromJson(
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
