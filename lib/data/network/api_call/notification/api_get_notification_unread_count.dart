/* 
Created by Neloy on 21 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import '../../../client/client.dart';
import '../../../client/client_constant.dart';
import '../../../model/model_error.dart';
import '../../api_path.dart';

abstract class IApiGetNotificationUnreadCount {
  Future<(int?, ModelError?)> getUnreadCount();
}

class ApiGetNotificationUnreadCount implements IApiGetNotificationUnreadCount {
  final Client client;

  const ApiGetNotificationUnreadCount({required this.client});

  @override
  Future<(int?, ModelError?)> getUnreadCount() async {
    try {
      final response = await client.request.get(
        ApiPath.notificationUnreadCount,
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        final count = response.data[ClientConstant.unreadCount];
        if (count is num) {
          return (count.toInt(), null);
        }
      }
      return (null, ModelError(error: [ClientConstant.serverError]));
    } catch (e) {
      return (null, ModelError(error: [ClientConstant.serverError]));
    }
  }
}
