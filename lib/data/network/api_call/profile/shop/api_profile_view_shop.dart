/* 
Created by Neloy on 23 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../../client/client.dart';
import '../../../../client/client_constant.dart';
import '../../../../model/model_error.dart';
import '../../../../model/model_profile_view_shop.dart';
import '../../../api_path.dart';

abstract class IApiProfileViewShop {
  Future<(ModelProfileViewShop?, ModelError?)> getProfileView();
}

class ApiProfileViewShop implements IApiProfileViewShop {
  final Client client;

  const ApiProfileViewShop({required this.client});

  @override
  Future<(ModelProfileViewShop?, ModelError?)> getProfileView() async {
    try {
      Response response = await client.request.get(ApiPath.viewShop);
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelProfileViewShop profile = ModelProfileViewShop.fromJson(
          response.data,
        );
        return (profile, null);
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
