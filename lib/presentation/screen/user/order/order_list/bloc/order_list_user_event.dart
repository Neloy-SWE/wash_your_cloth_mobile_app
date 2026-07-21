/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'order_list_user_bloc.dart';

sealed class OrderListUserEvent extends Equatable {
  const OrderListUserEvent();

  @override
  List<Object?> get props => [];
}

class OrderListUserEventFetch extends OrderListUserEvent {}