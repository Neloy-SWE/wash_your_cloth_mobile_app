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
  final bool isUpdating;
  final String actionMessage;
  final String actionError;

  const OrderDetailsShopStateFetch({
    required this.orderDetailsShop,
    this.isUpdating = false,
    this.actionMessage = "",
    this.actionError = "",
  });

  OrderDetailsShopStateFetch copyWith({
    ModelOrderDetailsShop? orderDetailsShop,
    bool? isUpdating,
    String? actionMessage,
    String? actionError,
  }) => OrderDetailsShopStateFetch(
    orderDetailsShop: orderDetailsShop ?? this.orderDetailsShop,
    isUpdating: isUpdating ?? this.isUpdating,
    actionMessage: actionMessage ?? "",
    actionError: actionError ?? "",
  );

  @override
  List<Object?> get props => [
    orderDetailsShop,
    isUpdating,
    actionMessage,
    actionError,
  ];
}

class OrderDetailsShopStateResult extends OrderDetailsShopState {
  final String message;

  const OrderDetailsShopStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
