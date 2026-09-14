/* 
Created by Neloy on 13 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_otp_request.dart';

import '../../../client/client.dart';
import '../../../client/client_constant.dart';
import '../../../model/model_error.dart';
import '../../api_path.dart';

abstract class IApiChangePassword {
  Future<(ModelOTPRequest?, ModelError?)> changePassword({
    required Map<String, dynamic> data,
  });
}

class ApiChangePassword implements IApiChangePassword {
  final Client client;

  const ApiChangePassword({required this.client});

  @override
  Future<(ModelOTPRequest?, ModelError?)> changePassword({
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await client.request.patch(
        ApiPath.changePassword,
        data: data,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelOTPRequest result = ModelOTPRequest.fromJson(response.data);
        return (result, null);
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
