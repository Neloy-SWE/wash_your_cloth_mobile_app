/* 
Created by Neloy on 14 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'item_add_bloc.dart';

sealed class ItemAddState extends Equatable {
  const ItemAddState();

  @override
  List<Object?> get props => [];
}

class ItemAddStateInitial extends ItemAddState {}

class ItemAddStateLoading extends ItemAddState {}

class ItemAddStateResult extends ItemAddState {
  final bool isNavigate;
  final String message;

  const ItemAddStateResult({
    required this.message,
    required this.isNavigate,
  });

  @override
  List<Object?> get props => [message, isNavigate];
}