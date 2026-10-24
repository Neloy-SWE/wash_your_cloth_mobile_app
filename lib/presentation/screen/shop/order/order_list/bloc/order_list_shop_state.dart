/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'order_list_shop_bloc.dart';

sealed class OrderListShopState extends Equatable {
  const OrderListShopState();

  @override
  List<Object?> get props => [];
}

class OrderListShopStateInitial extends OrderListShopState {}

class OrderListShopStateLoading extends OrderListShopState {}

class OrderListShopStateFetch extends OrderListShopState {
  final List<ModelOrderList> orderList;
  final int currentPage;
  final int pageSize;
  final int totalItem;
  final String search;
  final bool isLoadingMore;
  final String loadMoreError;

  const OrderListShopStateFetch({
    required this.orderList,
    this.currentPage = 0,
    this.pageSize = ClientConstant.defaultPageSize,
    this.totalItem = 0,
    this.search = '',
    this.isLoadingMore = false,
    this.loadMoreError = '',
  });

  bool get hasMore => orderList.length < totalItem;

  @override
  List<Object?> get props => [
    orderList,
    currentPage,
    pageSize,
    totalItem,
    search,
    isLoadingMore,
    loadMoreError,
  ];

  OrderListShopStateFetch copyWith({
    List<ModelOrderList>? orderList,
    int? currentPage,
    int? pageSize,
    int? totalItem,
    String? search,
    bool? isLoadingMore,
    String? loadMoreError,
  }) => OrderListShopStateFetch(
    orderList: orderList ?? this.orderList,
    currentPage: currentPage ?? this.currentPage,
    pageSize: pageSize ?? this.pageSize,
    totalItem: totalItem ?? this.totalItem,
    search: search ?? this.search,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    loadMoreError: loadMoreError ?? this.loadMoreError,
  );
}

class OrderListShopStateResult extends OrderListShopState {
  final String message;

  const OrderListShopStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
