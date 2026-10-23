/* 
Created by Neloy on 18 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'order_details_user_bloc.dart';

sealed class OrderDetailsUserEvent extends Equatable {
  const OrderDetailsUserEvent();

  @override
  List<Object?> get props => [];
}

class OrderDetailsUserEventFetch extends OrderDetailsUserEvent {
  final String orderId;

  const OrderDetailsUserEventFetch({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class OrderDetailsUserEventUpdateStatus extends OrderDetailsUserEvent {
  final String orderId;
  final OrderStatusAction action;

  const OrderDetailsUserEventUpdateStatus({
    required this.orderId,
    required this.action,
  });

  @override
  List<Object?> get props => [orderId, action];
}
