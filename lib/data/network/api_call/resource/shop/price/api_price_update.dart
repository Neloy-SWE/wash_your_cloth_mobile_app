/* 
Created by Neloy on 09 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_price_update.dart';
import '../../../../api_path.dart';

abstract class IApiPriceUpdate {
  Future<(ModelPriceUpdate?, ModelError?)> priceUpdate({
    required Map<String, dynamic> data,
    required String priceId,
  });
}

class ApiPriceUpdate implements IApiPriceUpdate {
  final Client client;

  const ApiPriceUpdate({required this.client});

  @override
  Future<(ModelPriceUpdate?, ModelError?)> priceUpdate({
    required Map<String, dynamic> data,
    required String priceId,
  }) async {
    try {
      Response response = await client.request.patch(
        ApiPath.priceUpdate + priceId,
        data: data,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelPriceUpdate activation = ModelPriceUpdate.fromJson(response.data);
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
