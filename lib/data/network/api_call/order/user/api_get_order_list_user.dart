/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../client/client.dart';
import '../../../../client/client_constant.dart';
import '../../../../model/model_error.dart';
import '../../../../model/model_order_list.dart';
import '../../../api_path.dart';

abstract class IApiGetOrderListUser {
  Future<(List<ModelOrderList>?, ModelError?)> getOrderList();
}

class ApiGetOrderListUser implements IApiGetOrderListUser {
  final Client client;

  const ApiGetOrderListUser({required this.client});

  @override
  Future<(List<ModelOrderList>?, ModelError?)> getOrderList() async {
    try {
      Response response = await client.request.get(ApiPath.orderListUser);

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
