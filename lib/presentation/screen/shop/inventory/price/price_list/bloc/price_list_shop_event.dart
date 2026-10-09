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

class PriceListShopEventUpdate extends PriceListShopEvent {
  final double price;
  final double discountPrice;
  final double ironPressPrice;
  final String priceId;

  const PriceListShopEventUpdate({
    required this.price,
    required this.discountPrice,
    required this.ironPressPrice,
    required this.priceId,
  });

  @override
  List<Object?> get props => [price, discountPrice, ironPressPrice, priceId];
}
