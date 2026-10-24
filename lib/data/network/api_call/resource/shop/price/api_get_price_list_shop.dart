/* 
Created by Neloy on 02 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_price_list_shop.dart';
import '../../../../../model/model_paged_list.dart';
import '../../../../api_path.dart';

abstract class IApiGetPriceListShop {
  Future<(ModelPagedList<ModelPriceListShop>?, ModelError?)> getPriceList({
    required int currentPage,
    required int pageSize,
    String? search,
  });
}

class ApiGetPriceListShop implements IApiGetPriceListShop {
  final Client client;

  const ApiGetPriceListShop({required this.client});

  @override
  Future<(ModelPagedList<ModelPriceListShop>?, ModelError?)> getPriceList({
    required int currentPage,
    required int pageSize,
    String? search,
  }) async {
    try {
      Response response = await client.request.get(
        ApiPath.priceListShop,
        queryParameters: {
          ClientConstant.currentPage: currentPage,
          ClientConstant.pageSize: pageSize,
          if (search?.trim().isNotEmpty == true)
            ClientConstant.search: search!.trim(),
        },
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        var modelPriceListShop = ModelPagedList<ModelPriceListShop>.fromJson(
          Map<String, dynamic>.from(response.data as Map),
          ModelPriceListShop.fromJson,
        );
        return (modelPriceListShop, null);
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
