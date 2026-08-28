/* 
Created by Neloy on 31 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'shop_details_user_bloc.dart';

sealed class ShopDetailsUserEvent extends Equatable {
  const ShopDetailsUserEvent();

  @override
  List<Object?> get props => [];
}

class ShopDetailsUserEventFetch extends ShopDetailsUserEvent {
  final String shopId;

  const ShopDetailsUserEventFetch({required this.shopId});

  @override
  List<Object?> get props => [shopId];
}
