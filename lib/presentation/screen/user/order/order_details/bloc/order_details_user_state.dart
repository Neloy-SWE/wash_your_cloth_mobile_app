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

  const OrderDetailsUserStateFetch({required this.orderDetailsUser});

  @override
  List<Object?> get props => [orderDetailsUser];
}

class OrderDetailsUserStateResult extends OrderDetailsUserState {
  final String message;

  const OrderDetailsUserStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
