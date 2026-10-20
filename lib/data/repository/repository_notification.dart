/* 
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import '../model/model_notification_list.dart';
import '../network/api_call/notification/api_get_notification_list.dart';
import '../use_case/use_case_generic.dart';

abstract class IRepositoryNotification {
  Future<UseCaseGeneric<ModelNotificationList>> getList();
}

class RepositoryNotification implements IRepositoryNotification {
  final IApiGetNotificationList apiGetNotificationList;

  const RepositoryNotification({required this.apiGetNotificationList});

  @override
  Future<UseCaseGeneric<ModelNotificationList>> getList() async {
    try {
      var (modelNotificationList, modelError) = await apiGetNotificationList
          .getList();
      if (modelError == null) {
        return UseCaseGeneric(isSuccess: true, data: modelNotificationList);
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }
}
