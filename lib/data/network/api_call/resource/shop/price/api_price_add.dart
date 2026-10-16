/* 
Created by Neloy on 16 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_price_add.dart';
import '../../../../api_path.dart';

abstract class IApiPriceAdd {
  Future<(ModelPriceAdd?, ModelError?)> priceAdd({
    required Map<String, dynamic> data,
  });
}

class ApiPriceAdd implements IApiPriceAdd {
  final Client client;

  const ApiPriceAdd({required this.client});

  @override
  Future<(ModelPriceAdd?, ModelError?)> priceAdd({
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await client.request.post(
        ApiPath.priceAdd,
        data: data,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelPriceAdd activation = ModelPriceAdd.fromJson(response.data);
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
