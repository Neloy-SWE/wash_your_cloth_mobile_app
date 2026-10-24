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
  final int currentPage;
  final int pageSize;
  final int totalItem;
  final String search;
  final bool isLoadingMore;
  final String loadMoreError;

  const ItemListStateFetch({
    required this.itemList,
    this.isActivating = false,
    this.isUpdating = false,
    this.currentPage = 0,
    this.pageSize = ClientConstant.defaultPageSize,
    this.totalItem = 0,
    this.search = '',
    this.isLoadingMore = false,
    this.loadMoreError = '',
  });

  bool get hasMore => itemList.length < totalItem;

  ItemListStateFetch copyWith({
    List<ModelItemList>? itemList,
    bool? isActivating,
    bool? isUpdating,
    int? currentPage,
    int? pageSize,
    int? totalItem,
    String? search,
    bool? isLoadingMore,
    String? loadMoreError,
  }) {
    return ItemListStateFetch(
      itemList: itemList ?? this.itemList,
      isActivating: isActivating ?? this.isActivating,
      isUpdating: isUpdating ?? this.isUpdating,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      totalItem: totalItem ?? this.totalItem,
      search: search ?? this.search,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreError: loadMoreError ?? this.loadMoreError,
    );
  }

  @override
  List<Object?> get props => [
    itemList,
    isActivating,
    isUpdating,
    currentPage,
    pageSize,
    totalItem,
    search,
    isLoadingMore,
    loadMoreError,
  ];
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
