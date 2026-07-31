/* 
Created by Neloy on 31 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'shop_details_user_bloc.dart';

sealed class ShopDetailsUserState extends Equatable {
  const ShopDetailsUserState();

  @override
  List<Object?> get props => [];
}

class ShopDetailsUserStateInitial extends ShopDetailsUserState {}

class ShopDetailsUserStateLoading extends ShopDetailsUserState {}

class ShopDetailsUserStateFetch extends ShopDetailsUserState {
  final ModelShopDetails shopDetailsUser;

  const ShopDetailsUserStateFetch({required this.shopDetailsUser});

  @override
  List<Object?> get props => [shopDetailsUser];
}

class ShopDetailsUserStateResult extends ShopDetailsUserState {
  final String message;

  const ShopDetailsUserStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
