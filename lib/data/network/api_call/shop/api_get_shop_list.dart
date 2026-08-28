/* 
Created by Neloy on 21 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../client/client.dart';
import '../../../client/client_constant.dart';
import '../../../model/model_error.dart';
import '../../../model/model_shop_list.dart';
import '../../api_path.dart';

abstract class IApiGetShopList {
  Future<(List<ModelShopList>?, ModelError?)> getShopList();
}

class ApiGetShopList implements IApiGetShopList {
  final Client client;

  const ApiGetShopList({required this.client});

  @override
  Future<(List<ModelShopList>?, ModelError?)> getShopList() async {
    try {
      Response response = await client.request.get(ApiPath.shopList);
      if (response.statusCode == ClientConstant.statusCode200OK) {
        var modelShopList = List<ModelShopList>.from(
          response.data.map((x) => ModelShopList.fromJson(x)),
        );
        return (modelShopList, null);
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
