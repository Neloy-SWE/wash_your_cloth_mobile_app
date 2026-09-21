/* 
Created by Neloy on 18 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'order_details_shop_bloc.dart';

sealed class OrderDetailsShopState extends Equatable {
  const OrderDetailsShopState();

  @override
  List<Object?> get props => [];
}

class OrderDetailsShopStateInitial extends OrderDetailsShopState {}

class OrderDetailsShopStateLoading extends OrderDetailsShopState {}

class OrderDetailsShopStateFetch extends OrderDetailsShopState {
  final ModelOrderDetailsShop orderDetailsShop;

  const OrderDetailsShopStateFetch({required this.orderDetailsShop});

  @override
  List<Object?> get props => [orderDetailsShop];
}

class OrderDetailsShopStateResult extends OrderDetailsShopState {
  final String message;

  const OrderDetailsShopStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
