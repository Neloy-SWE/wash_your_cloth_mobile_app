/* 
Created by Neloy on 18 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'order_details_user_bloc.dart';

sealed class OrderDetailsUserState extends Equatable {
  const OrderDetailsUserState();

  @override
  List<Object?> get props => [];
}

class OrderDetailsUserStateInitial extends OrderDetailsUserState {}

class OrderDetailsUserStateLoading extends OrderDetailsUserState {}

class OrderDetailsUserStateFetch extends OrderDetailsUserState {
  final ModelOrderDetailsUser orderDetailsUser;
  final bool isUpdating;
  final String actionMessage;
  final String actionError;

  const OrderDetailsUserStateFetch({
    required this.orderDetailsUser,
    this.isUpdating = false,
    this.actionMessage = "",
    this.actionError = "",
  });

  OrderDetailsUserStateFetch copyWith({
    ModelOrderDetailsUser? orderDetailsUser,
    bool? isUpdating,
    String? actionMessage,
    String? actionError,
  }) => OrderDetailsUserStateFetch(
    orderDetailsUser: orderDetailsUser ?? this.orderDetailsUser,
    isUpdating: isUpdating ?? this.isUpdating,
    actionMessage: actionMessage ?? "",
    actionError: actionError ?? "",
  );

  @override
  List<Object?> get props => [
    orderDetailsUser,
    isUpdating,
    actionMessage,
    actionError,
  ];
}

class OrderDetailsUserStateResult extends OrderDetailsUserState {
  final String message;

  const OrderDetailsUserStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
