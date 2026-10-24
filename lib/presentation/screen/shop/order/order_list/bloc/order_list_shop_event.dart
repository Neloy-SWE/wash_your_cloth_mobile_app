/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'order_list_shop_bloc.dart';

sealed class OrderListShopEvent extends Equatable {
  const OrderListShopEvent();

  @override
  List<Object?> get props => [];
}

class OrderListShopEventFetch extends OrderListShopEvent {
  final String? query;
  final bool debounce;

  const OrderListShopEventFetch({this.query, this.debounce = false});

  @override
  List<Object?> get props => [query, debounce];
}

class OrderListShopEventLoadMore extends OrderListShopEvent {}
