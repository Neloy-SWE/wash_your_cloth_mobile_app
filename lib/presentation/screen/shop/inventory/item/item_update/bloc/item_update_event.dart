/* 
Created by Neloy on 14 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'item_update_bloc.dart';

sealed class ItemUpdateEvent extends Equatable {
  const ItemUpdateEvent();

  @override
  List<Object?> get props => [];
}

class ItemUpdateEventSubmit extends ItemUpdateEvent {
  final String itemName;
  final String itemId;

  const ItemUpdateEventSubmit({required this.itemName, required this.itemId});

  @override
  List<Object?> get props => [itemName, itemId];
}
