/* 
Created by Neloy on 14 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'item_list_bloc.dart';

sealed class ItemListEvent extends Equatable {
  const ItemListEvent();

  @override
  List<Object?> get props => [];
}

class ItemListEventFetch extends ItemListEvent {}

class ItemListEventActivation extends ItemListEvent {
  final String itemId;

  const ItemListEventActivation({required this.itemId});

  @override
  List<Object?> get props => [itemId];
}

class ItemListEventUpdate extends ItemListEvent {
  final String itemName;
  final String itemId;

  const ItemListEventUpdate({
    required this.itemName,
    required this.itemId,
  });

  @override
  List<Object?> get props => [itemName, itemId];
}
