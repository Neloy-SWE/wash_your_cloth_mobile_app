/* 
Created by Neloy on 25 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'shop_list_bloc.dart';

sealed class ShopListState extends Equatable {
  const ShopListState();

  @override
  List<Object?> get props => [];
}

class ShopListStateInitial extends ShopListState {}

class ShopListStateLoading extends ShopListState {}

class ShopListStateFetch extends ShopListState {
  final List<ModelShopList> shopList;
  final int currentPage;
  final int pageSize;
  final int totalItem;
  final String search;
  final bool isLoadingMore;
  final String loadMoreError;

  const ShopListStateFetch({
    required this.shopList,
    this.currentPage = 0,
    this.pageSize = ClientConstant.defaultPageSize,
    this.totalItem = 0,
    this.search = '',
    this.isLoadingMore = false,
    this.loadMoreError = '',
  });

  bool get hasMore => shopList.length < totalItem;

  @override
  List<Object?> get props => [
    shopList,
    currentPage,
    pageSize,
    totalItem,
    search,
    isLoadingMore,
    loadMoreError,
  ];

  ShopListStateFetch copyWith({
    List<ModelShopList>? shopList,
    int? currentPage,
    int? pageSize,
    int? totalItem,
    String? search,
    bool? isLoadingMore,
    String? loadMoreError,
  }) => ShopListStateFetch(
    shopList: shopList ?? this.shopList,
    currentPage: currentPage ?? this.currentPage,
    pageSize: pageSize ?? this.pageSize,
    totalItem: totalItem ?? this.totalItem,
    search: search ?? this.search,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    loadMoreError: loadMoreError ?? this.loadMoreError,
  );
}

class ShopListStateResult extends ShopListState {
  final String message;

  const ShopListStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
