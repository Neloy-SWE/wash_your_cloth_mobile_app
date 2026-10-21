/*
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'notification_status_bloc.dart';

class NotificationStatusState extends Equatable {
  final int unreadCount;
  final Notification? latestNotification;

  const NotificationStatusState({
    this.unreadCount = 0,
    this.latestNotification,
  });

  NotificationStatusState copyWith({
    int? unreadCount,
    Notification? latestNotification,
  }) => NotificationStatusState(
    unreadCount: unreadCount ?? this.unreadCount,
    latestNotification: latestNotification ?? this.latestNotification,
  );

  @override
  List<Object?> get props => [unreadCount, latestNotification?.id];
}
