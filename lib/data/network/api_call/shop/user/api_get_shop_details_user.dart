/* 
Created by Neloy on 31 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../client/client.dart';
import '../../../../client/client_constant.dart';
import '../../../../model/model_error.dart';
import '../../../../model/model_shop_details.dart';
import '../../../api_path.dart';

abstract class IApiGetShopDetailsUser {
  Future<(ModelShopDetails?, ModelError?)> getDetails({required String shopId});
}

class ApiGetShopDetailsUser implements IApiGetShopDetailsUser {
  final Client client;

  const ApiGetShopDetailsUser({required this.client});

  @override
  Future<(ModelShopDetails?, ModelError?)> getDetails({
    required String shopId,
  }) async {
    try {
      Response response = await client.request.get(
        ApiPath.shopDetails + shopId,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelShopDetails modelShopDetails = ModelShopDetails.fromJson(
          response.data,
        );
        return (modelShopDetails, null);
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
