/* 
Created by Neloy on 13 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_item_list.dart';
import '../../../../api_path.dart';

abstract class IApiGetItemList {
  Future<(List<ModelItemList>?, ModelError?)> getItemList();
}

class ApiGetItemList implements IApiGetItemList {
  final Client client;

  const ApiGetItemList({required this.client});

  @override
  Future<(List<ModelItemList>?, ModelError?)> getItemList() async {
    try {
      Response response = await client.request.get(ApiPath.itemList);
      if (response.statusCode == ClientConstant.statusCode200OK) {
        var modelItemList = List<ModelItemList>.from(
          response.data.map((x) => ModelItemList.fromJson(x)),
        );
        return (modelItemList, null);
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
