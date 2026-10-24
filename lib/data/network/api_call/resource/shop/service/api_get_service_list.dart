/* 
Created by Neloy on 10 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_service_list.dart';
import '../../../../../model/model_paged_list.dart';
import '../../../../api_path.dart';

abstract class IApiGetServiceList {
  Future<(ModelPagedList<ModelServiceList>?, ModelError?)> getServiceList({
    required int currentPage,
    required int pageSize,
    String? search,
  });
}

class ApiGetServiceList implements IApiGetServiceList {
  final Client client;

  const ApiGetServiceList({required this.client});

  @override
  Future<(ModelPagedList<ModelServiceList>?, ModelError?)> getServiceList({
    required int currentPage,
    required int pageSize,
    String? search,
  }) async {
    try {
      Response response = await client.request.get(
        ApiPath.serviceList,
        queryParameters: {
          ClientConstant.currentPage: currentPage,
          ClientConstant.pageSize: pageSize,
          if (search?.trim().isNotEmpty == true)
            ClientConstant.search: search!.trim(),
        },
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        var modelServiceList = ModelPagedList<ModelServiceList>.fromJson(
          Map<String, dynamic>.from(response.data as Map),
          ModelServiceList.fromJson,
        );
        return (modelServiceList, null);
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
