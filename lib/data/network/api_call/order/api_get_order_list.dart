/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../client/client.dart';
import '../../../client/client_constant.dart';
import '../../../model/model_error.dart';
import '../../../model/model_order_list.dart';
import '../../../model/model_paged_list.dart';
import '../../api_path.dart';

abstract class IApiGetOrderList {
  Future<(ModelPagedList<ModelOrderList>?, ModelError?)> getOrderList({
    required int currentPage,
    required int pageSize,
    String? search,
  });
}

class ApiGetOrderList implements IApiGetOrderList {
  final Client client;

  const ApiGetOrderList({required this.client});

  @override
  Future<(ModelPagedList<ModelOrderList>?, ModelError?)> getOrderList({
    required int currentPage,
    required int pageSize,
    String? search,
  }) async {
    try {
      Response response = await client.request.get(
        ApiPath.orderList,
        queryParameters: {
          ClientConstant.currentPage: currentPage,
          ClientConstant.pageSize: pageSize,
          if (search?.trim().isNotEmpty == true)
            ClientConstant.search: search!.trim(),
        },
      );

      if (response.statusCode == ClientConstant.statusCode200OK) {
        var modelOrderList = ModelPagedList<ModelOrderList>.fromJson(
          Map<String, dynamic>.from(response.data as Map),
          ModelOrderList.fromJson,
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
