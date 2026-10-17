/* 
Created by Neloy on 12 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../../client/client.dart';
import '../../../../../client/client_constant.dart';
import '../../../../../model/model_error.dart';
import '../../../../../model/model_item_add.dart';
import '../../../../api_path.dart';

abstract class IApiItemAdd {
  Future<(ModelItemAdd?, ModelError?)> itemAdd({
    required Map<String, dynamic> data,
  });
}

class ApiItemAdd implements IApiItemAdd {
  final Client client;

  const ApiItemAdd({required this.client});

  @override
  Future<(ModelItemAdd?, ModelError?)> itemAdd({
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await client.request.post(
        ApiPath.itemAdd,
        data: data,
      );
      if (response.statusCode == ClientConstant.statusCode201Created) {
        ModelItemAdd itemAdd = ModelItemAdd.fromJson(response.data);
        return (itemAdd, null);
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
