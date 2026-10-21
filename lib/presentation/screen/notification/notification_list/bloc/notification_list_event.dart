/*
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'notification_list_bloc.dart';

sealed class NotificationListEvent extends Equatable {
  const NotificationListEvent();

  @override
  List<Object?> get props => [];
}

class NotificationListEventFetch extends NotificationListEvent {}

class NotificationListEventLoadMore extends NotificationListEvent {}

class NotificationListEventMarkRead extends NotificationListEvent {
  final String notificationId;

  const NotificationListEventMarkRead({required this.notificationId});

  @override
  List<Object?> get props => [notificationId];
}

class NotificationListEventNewNotification extends NotificationListEvent {
  final Notification notification;

  const NotificationListEventNewNotification({required this.notification});

  @override
  List<Object?> get props => [notification];
}
