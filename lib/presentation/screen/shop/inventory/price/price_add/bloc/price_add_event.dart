/* 
Created by Neloy on 16 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'price_add_bloc.dart';

sealed class PriceAddEvent extends Equatable {
  const PriceAddEvent();

  @override
  List<Object?> get props => [];
}

class PriceAddEventDropdownDataFetch extends PriceAddEvent {}

class PriceAddEventSubmit extends PriceAddEvent {
  final String serviceId;
  final String itemId;
  final double price;
  final double discountPrice;
  final double ironPressPrice;

  const PriceAddEventSubmit({
    required this.serviceId,
    required this.itemId,
    required this.price,
    required this.discountPrice,
    required this.ironPressPrice,
  });

  @override
  List<Object?> get props => [
    serviceId,
    itemId,
    price,
    discountPrice,
    ironPressPrice,
  ];
}
