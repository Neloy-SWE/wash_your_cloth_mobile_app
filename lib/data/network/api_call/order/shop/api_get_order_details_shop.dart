/* 
Created by Neloy on 21 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../client/client.dart';
import '../../../../client/client_constant.dart';
import '../../../../model/model_error.dart';
import '../../../../model/model_order_details_shop.dart';
import '../../../api_path.dart';

abstract class IApiGetOrderDetailsShop {
  Future<(ModelOrderDetailsShop?, ModelError?)> getDetails({
    required String orderId,
  });
}

class ApiGetOrderDetailsShop implements IApiGetOrderDetailsShop {
  final Client client;

  const ApiGetOrderDetailsShop({required this.client});

  @override
  Future<(ModelOrderDetailsShop?, ModelError?)> getDetails({
    required String orderId,
  }) async {
    try {
      Response response = await client.request.get(
        ApiPath.orderDetailsShop + orderId,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelOrderDetailsShop modelOrderDetailsShop =
            ModelOrderDetailsShop.fromJson(response.data);
        return (modelOrderDetailsShop, null);
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
