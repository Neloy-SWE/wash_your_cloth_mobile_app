/* 
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import '../model/model_notification_list.dart';
import '../model/model_error.dart';
import '../network/api_call/notification/api_get_notification_list.dart';
import '../network/api_call/notification/api_get_notification_unread_count.dart';
import '../network/api_call/notification/api_notification_mark_read.dart';
import '../use_case/use_case_generic.dart';
import '../client/client_constant.dart';

abstract class IRepositoryNotification {
  Future<UseCaseGeneric<ModelNotificationList>> getList({
    required int currentPage,
    required int pageSize,
  });

  Future<UseCaseGeneric<int>> getUnreadCount();

  Future<UseCaseGeneric<bool>> markRead({required String notificationId});
}

class RepositoryNotification implements IRepositoryNotification {
  final IApiGetNotificationList apiGetNotificationList;
  final IApiNotificationMarkRead apiNotificationMarkRead;
  final IApiGetNotificationUnreadCount apiGetNotificationUnreadCount;

  const RepositoryNotification({
    required this.apiGetNotificationList,
    required this.apiNotificationMarkRead,
    required this.apiGetNotificationUnreadCount,
  });

  @override
  Future<UseCaseGeneric<ModelNotificationList>> getList({
    required int currentPage,
    required int pageSize,
  }) async {
    try {
      var (modelNotificationList, modelError) = await apiGetNotificationList
          .getList(currentPage: currentPage, pageSize: pageSize);
      if (modelError == null) {
        return UseCaseGeneric(isSuccess: true, data: modelNotificationList);
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric<int>> getUnreadCount() async {
    try {
      final (count, modelError) = await apiGetNotificationUnreadCount
          .getUnreadCount();
      if (modelError == null && count != null) {
        return UseCaseGeneric(isSuccess: true, data: count);
      }
      return UseCaseGeneric.fromModelError(
        modelError ?? ModelError(error: [ClientConstant.serverError]),
      );
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric<bool>> markRead({
    required String notificationId,
  }) async {
    try {
      final (isMarked, modelError) = await apiNotificationMarkRead.markRead(
        notificationId: notificationId,
      );
      if (modelError == null && isMarked) {
        return UseCaseGeneric(isSuccess: true, data: true);
      }
      return UseCaseGeneric.fromModelError(
        modelError ?? ModelError(error: [ClientConstant.serverError]),
      );
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }
}
