/* 
Created by Neloy on 10 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_service_list.dart';
import '../../../../api_path.dart';

abstract class IApiGetServiceList {
  Future<(List<ModelServiceList>?, ModelError?)> getServiceList();
}

class ApiGetServiceList implements IApiGetServiceList {
  final Client client;

  const ApiGetServiceList({required this.client});

  @override
  Future<(List<ModelServiceList>?, ModelError?)> getServiceList() async {
    try {
      Response response = await client.request.get(ApiPath.serviceList);
      if (response.statusCode == ClientConstant.statusCode200OK) {
        var modelServiceList = List<ModelServiceList>.from(
          response.data.map((x) => ModelServiceList.fromJson(x)),
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
