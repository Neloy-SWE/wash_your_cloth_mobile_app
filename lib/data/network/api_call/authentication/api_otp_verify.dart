/* 
Created by Neloy on 11 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../client/client.dart';
import '../../../client/client_constant.dart';
import '../../../model/model_error.dart';
import '../../api_path.dart';

abstract class IApiOTPVerify {
  Future<(String?, ModelError?)> verify({required Map<String, dynamic> data});
}

class ApiOTPVerify implements IApiOTPVerify {
  final Client client;

  const ApiOTPVerify({required this.client});

  @override
  Future<(String?, ModelError?)> verify({
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await client.request.post(
        ApiPath.otpVerify,
        data: data,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        String message = response.data[ClientConstant.message];
        return (message, null);
      } else {
        ModelError modelError = ModelError.fromJson(response.data);
        return (null, modelError);
      }
    } catch (e) {
      ModelError modelError = ModelError(error: []);
      return (null, modelError);
    }
  }
}
