/* 
Created by Neloy on 21 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../client/client.dart';
import '../../../client/client_constant.dart';
import '../../../model/model_error.dart';
import '../../../model/model_shop_list.dart';
import '../../../model/model_paged_list.dart';
import '../../api_path.dart';

abstract class IApiGetShopList {
  Future<(ModelPagedList<ModelShopList>?, ModelError?)> getShopList({
    required int currentPage,
    required int pageSize,
    String? search,
  });
}

class ApiGetShopList implements IApiGetShopList {
  final Client client;

  const ApiGetShopList({required this.client});

  @override
  Future<(ModelPagedList<ModelShopList>?, ModelError?)> getShopList({
    required int currentPage,
    required int pageSize,
    String? search,
  }) async {
    try {
      Response response = await client.request.get(
        ApiPath.shopList,
        queryParameters: {
          ClientConstant.currentPage: currentPage,
          ClientConstant.pageSize: pageSize,
          if (search?.trim().isNotEmpty == true)
            ClientConstant.search: search!.trim(),
        },
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        var modelShopList = ModelPagedList<ModelShopList>.fromJson(
          Map<String, dynamic>.from(response.data as Map),
          ModelShopList.fromJson,
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
