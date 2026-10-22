/* 
Created by Neloy on 18 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'order_details_shop_bloc.dart';

sealed class OrderDetailsShopEvent extends Equatable {
  const OrderDetailsShopEvent();

  @override
  List<Object?> get props => [];
}

class OrderDetailsShopEventFetch extends OrderDetailsShopEvent {
  final String orderId;

  const OrderDetailsShopEventFetch({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class OrderDetailsShopEventUpdateStatus extends OrderDetailsShopEvent {
  final String orderId;
  final OrderStatusAction action;

  const OrderDetailsShopEventUpdateStatus({
    required this.orderId,
    required this.action,
  });

  @override
  List<Object?> get props => [orderId, action];
}
