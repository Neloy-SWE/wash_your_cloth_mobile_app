/*
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/client/client_constant.dart';
import '../../../../../data/model/model_notification_list.dart';
import '../../../../../data/repository/repository_notification.dart';

part 'notification_list_event.dart';

part 'notification_list_state.dart';

class NotificationListBloc
    extends Bloc<NotificationListEvent, NotificationListState> {
  static const int _pageSize = 15;

  final IRepositoryNotification repositoryNotification;

  NotificationListBloc({required this.repositoryNotification})
    : super(const NotificationListState()) {
    on<NotificationListEventFetch>(_onFetch);
    on<NotificationListEventLoadMore>(_onLoadMore);
    on<NotificationListEventMarkRead>(_onMarkRead);
    on<NotificationListEventNewNotification>(_onNewNotification);
  }

  Future<void> _onFetch(
    NotificationListEventFetch event,
    Emitter<NotificationListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ""));
    final result = await repositoryNotification.getList(
      currentPage: 0,
      pageSize: _pageSize,
    );
    if (result.isSuccess && result.data != null) {
      final page = result.data!;
      emit(
        state.copyWith(
          notifications: page.notifications,
          currentPage: page.currentPage,
          pageSize: page.pageSize,
          totalItem: page.totalItem,
          isLoading: false,
          error: "",
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          error: result.message ?? ClientConstant.serverError,
        ),
      );
    }
  }

  Future<void> _onLoadMore(
    NotificationListEventLoadMore event,
    Emitter<NotificationListState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore || state.currentPage < 0) return;

    emit(state.copyWith(isLoadingMore: true, loadMoreError: ""));
    final result = await repositoryNotification.getList(
      currentPage: state.currentPage + 1,
      pageSize: state.pageSize,
    );
    if (result.isSuccess && result.data != null) {
      final page = result.data!;
      final loadedIds = state.notifications.map((item) => item.id).toSet();
      final additionalItems = page.notifications
          .where((item) => loadedIds.add(item.id))
          .toList();
      emit(
        state.copyWith(
          notifications: [...state.notifications, ...additionalItems],
          currentPage: page.currentPage,
          pageSize: page.pageSize,
          totalItem: page.totalItem,
          isLoadingMore: false,
          loadMoreError: "",
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoadingMore: false,
          loadMoreError: result.message ?? ClientConstant.serverError,
        ),
      );
    }
  }

  Future<void> _onMarkRead(
    NotificationListEventMarkRead event,
    Emitter<NotificationListState> emit,
  ) async {
    final index = state.notifications.indexWhere(
      (item) => item.id == event.notificationId,
    );
    if (index < 0 || state.notifications[index].isRead) return;

    emit(state.copyWith(actionError: ""));
    final result = await repositoryNotification.markRead(
      notificationId: event.notificationId,
    );
    if (result.isSuccess) {
      final notifications = [...state.notifications];
      notifications[index] = notifications[index].copyWith(isRead: true);
      emit(
        state.copyWith(
          notifications: notifications,
          lastReadNotificationId: event.notificationId,
          actionError: "",
        ),
      );
    } else {
      emit(
        state.copyWith(
          actionError: result.message ?? ClientConstant.serverError,
        ),
      );
    }
  }

  void _onNewNotification(
    NotificationListEventNewNotification event,
    Emitter<NotificationListState> emit,
  ) {
    if (state.notifications.any((item) => item.id == event.notification.id)) {
      return;
    }
    emit(
      state.copyWith(
        notifications: [event.notification, ...state.notifications],
        totalItem: state.totalItem + 1,
      ),
    );
  }
}
