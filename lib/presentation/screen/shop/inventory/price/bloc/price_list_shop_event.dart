/* 
Created by Neloy on 02 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'price_list_shop_bloc.dart';

sealed class PriceListShopEvent extends Equatable {
  const PriceListShopEvent();

  @override
  List<Object?> get props => [];
}

class PriceListShopEventFetch extends PriceListShopEvent {}

class PriceListShopEventActivation extends PriceListShopEvent {
  final String priceId;

  const PriceListShopEventActivation({required this.priceId});

  @override
  List<Object?> get props => [priceId];
}
