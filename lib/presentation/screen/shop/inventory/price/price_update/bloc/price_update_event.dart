/* 
Created by Neloy on 09 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'price_update_bloc.dart';

sealed class PriceUpdateEvent extends Equatable {
  const PriceUpdateEvent();

  @override
  List<Object?> get props => [];
}

class PriceUpdateEventSubmit extends PriceUpdateEvent {
  final double price;
  final double discountPrice;
  final double ironPressPrice;
  final String priceId;

  const PriceUpdateEventSubmit({
    required this.price,
    required this.discountPrice,
    required this.ironPressPrice,
    required this.priceId,
  });

  @override
  List<Object?> get props => [price, discountPrice, ironPressPrice, priceId];
}
