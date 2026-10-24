/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'order_list_user_bloc.dart';

sealed class OrderListUserState extends Equatable {
  const OrderListUserState();

  @override
  List<Object?> get props => [];
}

class OrderListUserStateInitial extends OrderListUserState {}

class OrderListUserStateLoading extends OrderListUserState {}

class OrderListUserStateFetch extends OrderListUserState {
  final List<ModelOrderList> orderList;
  final int currentPage;
  final int pageSize;
  final int totalItem;
  final String search;
  final bool isLoadingMore;
  final String loadMoreError;

  const OrderListUserStateFetch({
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

  OrderListUserStateFetch copyWith({
    List<ModelOrderList>? orderList,
    int? currentPage,
    int? pageSize,
    int? totalItem,
    String? search,
    bool? isLoadingMore,
    String? loadMoreError,
  }) => OrderListUserStateFetch(
    orderList: orderList ?? this.orderList,
    currentPage: currentPage ?? this.currentPage,
    pageSize: pageSize ?? this.pageSize,
    totalItem: totalItem ?? this.totalItem,
    search: search ?? this.search,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    loadMoreError: loadMoreError ?? this.loadMoreError,
  );
}

class OrderListUserStateResult extends OrderListUserState {
  final String message;

  const OrderListUserStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
