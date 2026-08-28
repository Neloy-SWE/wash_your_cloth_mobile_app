/*
Created by Neloy on 21 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../client/client.dart';
import '../../../../client/client_constant.dart';
import '../../../../model/model_error.dart';
import '../../../../model/model_order_place.dart';
import '../../../api_path.dart';

abstract class IApiPlaceOrder {
  Future<(ModelOrderPlace?, ModelError?)> placeOrder({
    required Map<String, dynamic> data,
  });
}

class ApiPlaceOrder implements IApiPlaceOrder {
  final Client client;

  const ApiPlaceOrder({required this.client});

  @override
  Future<(ModelOrderPlace?, ModelError?)> placeOrder({
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await client.request.post(ApiPath.place, data: data);
      if (response.statusCode == ClientConstant.statusCode201Created) {
        ModelOrderPlace modelOrderPlace = ModelOrderPlace.fromJson(
          response.data,
        );
        return (modelOrderPlace, null);
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
