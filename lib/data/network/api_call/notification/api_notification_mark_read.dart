/* 
Created by Neloy on 21 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import '../../../client/client.dart';
import '../../../client/client_constant.dart';
import '../../../model/model_error.dart';
import '../../api_path.dart';

abstract class IApiNotificationMarkRead {
  Future<(bool, ModelError?)> markRead({required String notificationId});
}

class ApiNotificationMarkRead implements IApiNotificationMarkRead {
  final Client client;

  const ApiNotificationMarkRead({required this.client});

  @override
  Future<(bool, ModelError?)> markRead({required String notificationId}) async {
    try {
      final response = await client.request.patch(
        "${ApiPath.notificationRead}$notificationId",
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        return (true, null);
      }
      return (false, ModelError.fromJson(response.data));
    } catch (e) {
      return (false, ModelError(error: [ClientConstant.serverError]));
    }
  }
}
