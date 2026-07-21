/* 
Created by Neloy on 17 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_order_details_user.dart';

import '../../../client/client.dart';
import '../../../client/client_constant.dart';
import '../../../model/model_error.dart';
import '../../api_path.dart';

abstract class IApiGetOrderDetailsUser {
  Future<(ModelOrderDetailsUser?, ModelError?)> getDetails({
    required String orderId,
  });
}

class ApiGetOrderDetailsUser implements IApiGetOrderDetailsUser {
  final Client client;

  const ApiGetOrderDetailsUser({required this.client});

  @override
  Future<(ModelOrderDetailsUser?, ModelError?)> getDetails({
    required String orderId,
  }) async {
    try {
      Response response = await client.request.get(
        ApiPath.orderDetailsUser + orderId,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelOrderDetailsUser modelOrderDetailsUser =
            ModelOrderDetailsUser.fromJson(response.data);
        return (modelOrderDetailsUser, null);
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
