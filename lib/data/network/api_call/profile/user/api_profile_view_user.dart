/* 
Created by Neloy on 30 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_path.dart';

import '../../../../client/client.dart';
import '../../../../client/client_constant.dart';
import '../../../../model/model_error.dart';
import '../../../../model/model_profile_view_user.dart';

abstract class IApiProfileViewUser {
  Future<(ModelProfileViewUser?, ModelError?)> getProfileView();
}

class ApiProfileViewUser implements IApiProfileViewUser {
  final Client client;

  const ApiProfileViewUser({required this.client});

  @override
  Future<(ModelProfileViewUser?, ModelError?)> getProfileView() async {
    try {
      Response response = await client.request.get(ApiPath.viewUser);
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelProfileViewUser modelShopDetails = ModelProfileViewUser.fromJson(
          response.data,
        );
        return (modelShopDetails, null);
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
