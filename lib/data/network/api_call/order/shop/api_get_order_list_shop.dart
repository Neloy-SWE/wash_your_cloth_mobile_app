/* 
Created by Neloy on 19 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../client/client.dart';
import '../../../../client/client_constant.dart';
import '../../../../model/model_error.dart';
import '../../../../model/model_order_list.dart';
import '../../../api_path.dart';

abstract class IApiGetOrderListShop {
  Future<(List<ModelOrderList>?, ModelError?)> getOrderList();
}

class ApiGetOrderListShop implements IApiGetOrderListShop {
  final Client client;

  const ApiGetOrderListShop({required this.client});

  @override
  Future<(List<ModelOrderList>?, ModelError?)> getOrderList() async {
    try {
      Response response = await client.request.get(ApiPath.orderListShop);

      if (response.statusCode == ClientConstant.statusCode200OK) {
        var modelOrderList = List<ModelOrderList>.from(
          response.data.map((x) => ModelOrderList.fromJson(x)),
        );

        return (modelOrderList, null);
      } else {
        ModelError modelError = ModelError.fromJson(response.data);
        return (null, modelError);
      }
    } catch (e) {
      ModelError modelError = ModelError(error: []);
      return (null, modelError);
    }
  }
}
