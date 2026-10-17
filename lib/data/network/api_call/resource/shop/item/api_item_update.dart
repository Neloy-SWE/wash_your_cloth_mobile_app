/* 
Created by Neloy on 11 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_item_update.dart';
import '../../../../api_path.dart';

abstract class IApiItemUpdate {
  Future<(ModelItemUpdate?, ModelError?)> itemUpdate({
    required Map<String, dynamic> data,
    required String itemId,
  });
}

class ApiItemUpdate implements IApiItemUpdate {
  final Client client;

  const ApiItemUpdate({required this.client});

  @override
  Future<(ModelItemUpdate?, ModelError?)> itemUpdate({
    required Map<String, dynamic> data,
    required String itemId,
  }) async {
    try {
      Response response = await client.request.patch(
        ApiPath.itemUpdate + itemId,
        data: data,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelItemUpdate itemUpdate = ModelItemUpdate.fromJson(
          response.data,
        );
        return (itemUpdate, null);
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
