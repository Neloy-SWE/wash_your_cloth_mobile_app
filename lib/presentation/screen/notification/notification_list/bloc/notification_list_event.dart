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
