/* 
Created by Neloy on 25 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'order_place_bloc.dart';

sealed class OrderPlaceEvent extends Equatable {
  const OrderPlaceEvent();

  @override
  List<Object?> get props => [];
}

class OrderPlaceEventSubmit extends OrderPlaceEvent {
  final OrderPlaceData orderPlaceData;

  const OrderPlaceEventSubmit({required this.orderPlaceData});

  @override
  List<Object?> get props => [orderPlaceData];
}
