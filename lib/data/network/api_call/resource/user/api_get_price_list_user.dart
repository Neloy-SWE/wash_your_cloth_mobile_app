/* 
Created by Neloy on 01 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../client/client.dart';
import '../../../../client/client_constant.dart';
import '../../../../model/model_error.dart';
import '../../../../model/model_price_list_user.dart';
import '../../../../model/model_paged_list.dart';
import '../../../api_path.dart';

abstract class IApiGetPriceListUser {
  Future<(ModelPagedList<ModelPriceListUser>?, ModelError?)> getPriceList({
    required String shopId,
    required int currentPage,
    required int pageSize,
    String? search,
  });
}

class ApiGetPriceListUser implements IApiGetPriceListUser {
  final Client client;

  const ApiGetPriceListUser({required this.client});

  @override
  Future<(ModelPagedList<ModelPriceListUser>?, ModelError?)> getPriceList({
    required String shopId,
    required int currentPage,
    required int pageSize,
    String? search,
  }) async {
    try {
      Response response = await client.request.get(
        ApiPath.priceListUser + shopId,
        queryParameters: {
          ClientConstant.currentPage: currentPage,
          ClientConstant.pageSize: pageSize,
          if (search?.trim().isNotEmpty == true)
            ClientConstant.search: search!.trim(),
        },
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        var modelPriceListUser = ModelPagedList<ModelPriceListUser>.fromJson(
          Map<String, dynamic>.from(response.data as Map),
          ModelPriceListUser.fromJson,
        );
        return (modelPriceListUser, null);
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
