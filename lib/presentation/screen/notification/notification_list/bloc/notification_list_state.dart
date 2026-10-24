/*
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'notification_list_bloc.dart';

class NotificationListState extends Equatable {
  final List<NotificationItem> notifications;
  final int currentPage;
  final int pageSize;
  final int totalItem;
  final String search;
  final bool isLoading;
  final bool hasLoaded;
  final bool isLoadingMore;
  final String error;
  final String loadMoreError;
  final String actionError;
  final String? lastReadNotificationId;

  const NotificationListState({
    this.notifications = const [],
    this.currentPage = -1,
    this.pageSize = ClientConstant.defaultPageSize,
    this.totalItem = 0,
    this.search = "",
    this.isLoading = false,
    this.hasLoaded = false,
    this.isLoadingMore = false,
    this.error = "",
    this.loadMoreError = "",
    this.actionError = "",
    this.lastReadNotificationId,
  });

  bool get hasMore => currentPage >= 0 && notifications.length < totalItem;

  NotificationListState copyWith({
    List<NotificationItem>? notifications,
    int? currentPage,
    int? pageSize,
    int? totalItem,
    String? search,
    bool? isLoading,
    bool? hasLoaded,
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
    search: search ?? this.search,
    isLoading: isLoading ?? this.isLoading,
    hasLoaded: hasLoaded ?? this.hasLoaded,
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
    search,
    isLoading,
    hasLoaded,
    isLoadingMore,
    error,
    loadMoreError,
    actionError,
    lastReadNotificationId,
  ];
}
