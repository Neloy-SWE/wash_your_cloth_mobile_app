/* 
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'notification_list_bloc.dart';

sealed class NotificationListState extends Equatable {
  const NotificationListState();

  @override
  List<Object?> get props => [];
}

class NotificationListStateInitial extends NotificationListState {}

class NotificationListStateLoading extends NotificationListState {}

class NotificationListStateFetch extends NotificationListState {
  final ModelNotificationList notificationList;

  const NotificationListStateFetch({required this.notificationList});

  @override
  List<Object?> get props => [notificationList];
}

class NotificationListStateResult extends NotificationListState {
  final String message;

  const NotificationListStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
