/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'order_list_user_bloc.dart';

sealed class OrderListUserState extends Equatable {
  const OrderListUserState();

  @override
  List<Object?> get props => [];
}

class OrderListUserStateInitial extends OrderListUserState {}

class OrderListUserStateLoading extends OrderListUserState {}

class OrderListUserStateFetch extends OrderListUserState {
  final List<ModelOrderList> orderList;

  const OrderListUserStateFetch({required this.orderList});
}

class OrderListUserStateResult extends OrderListUserState {
  final String message;

  const OrderListUserStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
