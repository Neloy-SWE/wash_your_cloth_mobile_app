/* 
Created by Neloy on 02 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_price_list_shop.dart';
import '../../../../api_path.dart';

abstract class IApiGetPriceListShop {
  Future<(List<ModelPriceListShop>?, ModelError?)> getPriceList();
}

class ApiGetPriceListShop implements IApiGetPriceListShop {
  final Client client;

  const ApiGetPriceListShop({required this.client});

  @override
  Future<(List<ModelPriceListShop>?, ModelError?)> getPriceList() async {
    try {
      Response response = await client.request.get(ApiPath.priceListShop);
      if (response.statusCode == ClientConstant.statusCode200OK) {
        var modelPriceListShop = List<ModelPriceListShop>.from(
          response.data.map((x) => ModelPriceListShop.fromJson(x)),
        );
        return (modelPriceListShop, null);
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
