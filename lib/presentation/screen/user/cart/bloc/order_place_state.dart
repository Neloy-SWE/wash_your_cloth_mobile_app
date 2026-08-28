/* 
Created by Neloy on 25 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'order_place_bloc.dart';

sealed class OrderPlaceState extends Equatable {
  const OrderPlaceState();

  @override
  List<Object?> get props => [];
}

class OrderPlaceStateInitial extends OrderPlaceState {}

class OrderPlaceStateLoading extends OrderPlaceState {}

class OrderPlaceStateResult extends OrderPlaceState {
  final bool isNavigate;
  final String message;

  const OrderPlaceStateResult({
    required this.message,
    required this.isNavigate,
  });

  @override
  List<Object?> get props => [message, isNavigate];
}
