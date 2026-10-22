/*
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'notification_status_bloc.dart';

sealed class NotificationStatusEvent extends Equatable {
  const NotificationStatusEvent();

  @override
  List<Object?> get props => [];
}

class NotificationStatusEventStart extends NotificationStatusEvent {
  const NotificationStatusEventStart();
}

class NotificationStatusEventRefresh extends NotificationStatusEvent {
  const NotificationStatusEventRefresh();
}

class NotificationStatusEventStop extends NotificationStatusEvent {
  const NotificationStatusEventStop();
}

class NotificationStatusEventIncoming extends NotificationStatusEvent {
  final NotificationItem notification;

  const NotificationStatusEventIncoming({required this.notification});

  @override
  List<Object?> get props => [notification.id];
}
