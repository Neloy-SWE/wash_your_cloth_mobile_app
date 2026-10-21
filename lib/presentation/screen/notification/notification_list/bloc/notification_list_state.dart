/*
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'notification_list_bloc.dart';

class NotificationListState extends Equatable {
  final List<Notification> notifications;
  final int currentPage;
  final int pageSize;
  final int totalItem;
  final bool isLoading;
  final bool isLoadingMore;
  final String error;
  final String loadMoreError;
  final String actionError;
  final String? lastReadNotificationId;

  const NotificationListState({
    this.notifications = const [],
    this.currentPage = -1,
    this.pageSize = 15,
    this.totalItem = 0,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error = "",
    this.loadMoreError = "",
    this.actionError = "",
    this.lastReadNotificationId,
  });

  bool get hasMore => notifications.length < totalItem;

  NotificationListState copyWith({
    List<Notification>? notifications,
    int? currentPage,
    int? pageSize,
    int? totalItem,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    String? loadMoreError,
    String? actionError,
    String? lastReadNotificationId,
  }) => NotificationListState(
    notifications: notifications ?? this.notifications,
    currentPage: currentPage ?? this.currentPage,
    pageSize: pageSize ?? this.pageSize,
    totalItem: totalItem ?? this.totalItem,
    isLoading: isLoading ?? this.isLoading,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    error: error ?? this.error,
    loadMoreError: loadMoreError ?? this.loadMoreError,
    actionError: actionError ?? this.actionError,
    lastReadNotificationId:
        lastReadNotificationId ?? this.lastReadNotificationId,
  );

  @override
  List<Object?> get props => [
    notifications,
    currentPage,
    pageSize,
    totalItem,
    isLoading,
    isLoadingMore,
    error,
    loadMoreError,
    actionError,
    lastReadNotificationId,
  ];
}
