/*
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/client/client_constant.dart';
import '../../../../../data/model/model_notification_item.dart';
import '../../../../../data/repository/repository_notification.dart';

part 'notification_list_event.dart';

part 'notification_list_state.dart';

class NotificationListBloc
    extends Bloc<NotificationListEvent, NotificationListState> {
  static const int _pageSize = ClientConstant.defaultPageSize;
  // A fresh fetch invalidates any outstanding load-more response.
  int _listRequestGeneration = 0;

  final IRepositoryNotification repositoryNotification;

  NotificationListBloc({required this.repositoryNotification})
    : super(const NotificationListState()) {
    on<NotificationListEventFetch>(_onFetch, transformer: restartable());
    on<NotificationListEventLoadMore>(_onLoadMore, transformer: droppable());
    on<NotificationListEventMarkRead>(_onMarkRead, transformer: sequential());
    on<NotificationListEventNewNotification>(_onNewNotification);
  }

  Future<void> _onFetch(
    NotificationListEventFetch event,
    Emitter<NotificationListState> emit,
  ) async {
    final generation = ++_listRequestGeneration;
    final query = (event.query ?? state.search).trim();
    if (event.debounce) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (emit.isDone) return;
    }
    final isNewQuery = query != state.search;
    emit(
      state.copyWith(
        currentPage: isNewQuery ? -1 : state.currentPage,
        search: query,
        isLoadingMore: false,
        isLoading: true,
        error: "",
        loadMoreError: "",
      ),
    );
    final result = await repositoryNotification.getList(
      currentPage: 0,
      pageSize: _pageSize,
      search: query,
    );
    if (emit.isDone || generation != _listRequestGeneration) return;
    if (result.isSuccess && result.data != null) {
      final page = result.data!;
      emit(
        state.copyWith(
          notifications: page.items,
          currentPage: page.currentPage,
          pageSize: page.pageSize,
          totalItem: page.totalItem,
          search: query,
          isLoading: false,
          hasLoaded: true,
          error: "",
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          hasLoaded: true,
          error: result.message ?? ClientConstant.serverError,
        ),
      );
    }
  }

  Future<void> _onLoadMore(
    NotificationListEventLoadMore event,
    Emitter<NotificationListState> emit,
  ) async {
    if (state.isLoading ||
        state.isLoadingMore ||
        !state.hasMore ||
        state.currentPage < 0) {
      return;
    }

    final generation = _listRequestGeneration;
    emit(state.copyWith(isLoadingMore: true, loadMoreError: ""));
    final result = await repositoryNotification.getList(
      currentPage: state.currentPage + 1,
      pageSize: state.pageSize,
      search: state.search,
    );
    if (emit.isDone || generation != _listRequestGeneration) return;
    if (result.isSuccess && result.data != null) {
      final page = result.data!;
      final loadedIds = state.notifications.map((item) => item.id).toSet();
      final additionalItems = page.items
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
    final query = state.search.trim().toLowerCase();
    if (query.isNotEmpty &&
        !event.notification.title.toLowerCase().contains(query) &&
        !event.notification.message.toLowerCase().contains(query) &&
        !event.notification.metaData.toLowerCase().contains(query)) {
      return;
    }
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
