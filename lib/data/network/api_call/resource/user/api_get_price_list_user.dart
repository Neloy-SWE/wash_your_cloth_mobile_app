/* 
Created by Neloy on 01 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../client/client.dart';
import '../../../../client/client_constant.dart';
import '../../../../model/model_error.dart';
import '../../../../model/model_price_list_user.dart';
import '../../../api_path.dart';

abstract class IApiGetPriceListUser {
  Future<(List<ModelPriceListUser>?, ModelError?)> getPriceList({
    required String shopId,
  });
}

class ApiGetPriceListUser implements IApiGetPriceListUser {
  final Client client;

  const ApiGetPriceListUser({required this.client});

  @override
  Future<(List<ModelPriceListUser>?, ModelError?)> getPriceList({
    required String shopId,
  }) async {
    try {
      Response response = await client.request.get(
        ApiPath.priceListUser + shopId,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        var modelPriceListUser = List<ModelPriceListUser>.from(
          response.data.map((x) => ModelPriceListUser.fromJson(x)),
        );
        return (modelPriceListUser, null);
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
