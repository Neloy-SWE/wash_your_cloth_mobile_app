/* 
Created by Neloy on 09 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'price_update_bloc.dart';

sealed class PriceUpdateState extends Equatable {
  const PriceUpdateState();

  @override
  List<Object?> get props => [];
}

class PriceUpdateStateInitial extends PriceUpdateState {}

class PriceUpdateStateLoading extends PriceUpdateState {}

class PriceUpdateStateResult extends PriceUpdateState {
  final bool isNavigate;
  final String message;

  const PriceUpdateStateResult({
    required this.message,
    required this.isNavigate,
  });

  @override
  List<Object?> get props => [message, isNavigate];
}
