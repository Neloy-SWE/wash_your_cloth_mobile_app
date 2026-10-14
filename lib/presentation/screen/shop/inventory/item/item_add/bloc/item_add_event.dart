/* 
Created by Neloy on 14 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'item_add_bloc.dart';

sealed class ItemAddEvent extends Equatable {
  const ItemAddEvent();

  @override
  List<Object?> get props => [];
}

class ItemAddEventSubmit extends ItemAddEvent {
  final String itemName;

  const ItemAddEventSubmit({required this.itemName});

  @override
  List<Object?> get props => [itemName];
}
