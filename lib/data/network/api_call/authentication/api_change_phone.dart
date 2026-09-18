/* 
Created by Neloy on 18 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../client/client.dart';
import '../../../client/client_constant.dart';
import '../../../model/model_error.dart';
import '../../../model/model_otp_request.dart';
import '../../api_path.dart';

abstract class IApiChangePhone {
  Future<(ModelOTPRequest?, ModelError?)> changePhone({
    required Map<String, dynamic> data,
  });
}

class ApiChangePhone implements IApiChangePhone {
  final Client client;

  const ApiChangePhone({required this.client});

  @override
  Future<(ModelOTPRequest?, ModelError?)> changePhone({
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await client.request.patch(
        ApiPath.changePhone,
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
