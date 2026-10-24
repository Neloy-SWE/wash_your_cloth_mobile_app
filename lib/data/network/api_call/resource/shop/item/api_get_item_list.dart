/* 
Created by Neloy on 13 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_item_list.dart';
import '../../../../../model/model_paged_list.dart';
import '../../../../api_path.dart';

abstract class IApiGetItemList {
  Future<(ModelPagedList<ModelItemList>?, ModelError?)> getItemList({
    required int currentPage,
    required int pageSize,
    String? search,
  });
}

class ApiGetItemList implements IApiGetItemList {
  final Client client;

  const ApiGetItemList({required this.client});

  @override
  Future<(ModelPagedList<ModelItemList>?, ModelError?)> getItemList({
    required int currentPage,
    required int pageSize,
    String? search,
  }) async {
    try {
      Response response = await client.request.get(
        ApiPath.itemList,
        queryParameters: {
          ClientConstant.currentPage: currentPage,
          ClientConstant.pageSize: pageSize,
          if (search?.trim().isNotEmpty == true)
            ClientConstant.search: search!.trim(),
        },
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        var modelItemList = ModelPagedList<ModelItemList>.fromJson(
          Map<String, dynamic>.from(response.data as Map),
          ModelItemList.fromJson,
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
