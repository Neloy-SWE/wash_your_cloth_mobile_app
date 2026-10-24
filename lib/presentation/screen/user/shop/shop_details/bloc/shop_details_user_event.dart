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
  final String? query;
  final bool debounce;
  final bool fetchDetails;

  const ShopDetailsUserEventFetch({
    required this.shopId,
    this.query,
    this.debounce = false,
    this.fetchDetails = true,
  });

  @override
  List<Object?> get props => [shopId, query, debounce, fetchDetails];
}

class ShopDetailsUserEventLoadMore extends ShopDetailsUserEvent {}
