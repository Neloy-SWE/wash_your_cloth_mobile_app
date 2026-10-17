/* 
Created by Neloy on 14 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'item_list_bloc.dart';

sealed class ItemListState extends Equatable {
  const ItemListState();

  @override
  List<Object?> get props => [];
}

class ItemListStateInitial extends ItemListState {}

class ItemListStateLoading extends ItemListState {}

class ItemListStateFetch extends ItemListState {
  final List<ModelItemList> itemList;
  final bool isActivating;
  final bool isUpdating;

  const ItemListStateFetch({
    required this.itemList,
    this.isActivating = false,
    this.isUpdating = false,
  });

  ItemListStateFetch copyWith({
    List<ModelItemList>? itemList,
    bool? isActivating,
    bool? isUpdating,
  }) {
    return ItemListStateFetch(
      itemList: itemList ?? this.itemList,
      isActivating: isActivating ?? this.isActivating,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }

  @override
  List<Object?> get props => [itemList, isActivating];
}

class ItemListStateError extends ItemListState {
  final String message;

  const ItemListStateError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ItemListStateActionResult extends ItemListState {
  final String message;
  final bool isSuccess;

  const ItemListStateActionResult({
    required this.message,
    required this.isSuccess,
  });

  @override
  List<Object?> get props => [message, isSuccess];
}
