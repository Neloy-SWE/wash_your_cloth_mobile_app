/* 
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/client/client_constant.dart';
import '../../../../../data/model/model_notification_list.dart';
import '../../../../../data/repository/repository_notification.dart';
import '../../../../../data/use_case/use_case_generic.dart';

part 'notification_list_event.dart';

part 'notification_list_state.dart';

class NotificationListBloc
    extends Bloc<NotificationListEvent, NotificationListState> {
  final IRepositoryNotification repositoryNotification;

  NotificationListBloc({required this.repositoryNotification})
    : super(NotificationListStateInitial()) {
    on<NotificationListEventFetch>(_onNotificationListEventFetch);
  }

  Future<void> _onNotificationListEventFetch(
    NotificationListEventFetch event,
    Emitter<NotificationListState> emit,
  ) async {
    emit(NotificationListStateLoading());
    try {
      UseCaseGeneric<ModelNotificationList> useCaseNotificationList =
          await repositoryNotification.getList();
      if (useCaseNotificationList.isSuccess) {
        emit(
          NotificationListStateFetch(
            notificationList: useCaseNotificationList.data!,
          ),
        );
      } else {
        emit(
          NotificationListStateResult(
            message: useCaseNotificationList.message!,
          ),
        );
      }
    } catch (e) {
      emit(NotificationListStateResult(message: ClientConstant.serverError));
    }
  }
}
