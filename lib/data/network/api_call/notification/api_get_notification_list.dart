/* 
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../client/client.dart';
import '../../../client/client_constant.dart';
import '../../../model/model_error.dart';
import '../../../model/model_notification_list.dart';
import '../../api_path.dart';

abstract class IApiGetNotificationList {
  Future<(ModelNotificationList?, ModelError?)> getList();
}

class ApiGetNotificationList implements IApiGetNotificationList {
  final Client client;

  const ApiGetNotificationList({required this.client});

  @override
  Future<(ModelNotificationList?, ModelError?)> getList() async {
    try {
      Response response = await client.request.get(
        ApiPath.notificationList,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        ModelNotificationList modelNotificationList =
        ModelNotificationList.fromJson(response.data);
        return (modelNotificationList, null);
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