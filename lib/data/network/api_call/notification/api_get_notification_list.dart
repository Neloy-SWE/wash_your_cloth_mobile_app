/* 
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../client/client.dart';
import '../../../client/client_constant.dart';
import '../../../model/model_error.dart';
import '../../../model/model_notification_item.dart';
import '../../../model/model_paged_list.dart';
import '../../api_path.dart';

abstract class IApiGetNotificationList {
  Future<(ModelPagedList<NotificationItem>?, ModelError?)> getList({
    required int currentPage,
    required int pageSize,
    String? search,
  });
}

class ApiGetNotificationList implements IApiGetNotificationList {
  final Client client;

  const ApiGetNotificationList({required this.client});

  @override
  Future<(ModelPagedList<NotificationItem>?, ModelError?)> getList({
    required int currentPage,
    required int pageSize,
    String? search,
  }) async {
    try {
      Response response = await client.request.get(
        ApiPath.notificationList,
        queryParameters: {
          ClientConstant.currentPage: currentPage,
          ClientConstant.pageSize: pageSize,
          if (search?.trim().isNotEmpty == true)
            ClientConstant.search: search!.trim(),
        },
      );
      if (response.statusCode == ClientConstant.statusCode200OK) {
        final pagedNotifications = ModelPagedList<NotificationItem>.fromJson(
          Map<String, dynamic>.from(response.data as Map),
          NotificationItem.fromJson,
          itemsKey: 'notifications',
        );
        return (pagedNotifications, null);
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
