/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'order_list_shop_bloc.dart';

sealed class OrderListShopState extends Equatable {
  const OrderListShopState();

  @override
  List<Object?> get props => [];
}

class OrderListShopStateInitial extends OrderListShopState {}

class OrderListShopStateLoading extends OrderListShopState {}

class OrderListShopStateFetch extends OrderListShopState {
  final List<ModelOrderList> orderList;

  const OrderListShopStateFetch({required this.orderList});

  @override
  List<Object?> get props => [orderList];
}

class OrderListShopStateResult extends OrderListShopState {
  final String message;

  const OrderListShopStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
