/* 
Created by Neloy on 25 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'shop_list_bloc.dart';

sealed class ShopListEvent extends Equatable {
  const ShopListEvent();

  @override
  List<Object?> get props => [];
}

class ShopListEventFetch extends ShopListEvent {}