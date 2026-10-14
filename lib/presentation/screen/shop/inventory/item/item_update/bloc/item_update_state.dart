/* 
Created by Neloy on 14 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'item_update_bloc.dart';

sealed class ItemUpdateState extends Equatable {
  const ItemUpdateState();

  @override
  List<Object?> get props => [];
}

class ItemUpdateStateInitial extends ItemUpdateState {}

class ItemUpdateStateLoading extends ItemUpdateState {}

class ItemUpdateStateResult extends ItemUpdateState {
  final bool isNavigate;
  final String message;

  const ItemUpdateStateResult({
    required this.message,
    required this.isNavigate,
  });

  @override
  List<Object?> get props => [message, isNavigate];
}
