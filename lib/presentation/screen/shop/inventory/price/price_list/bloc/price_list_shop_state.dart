/* 
Created by Neloy on 02 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'price_list_shop_bloc.dart';

sealed class PriceListShopState extends Equatable {
  const PriceListShopState();

  @override
  List<Object?> get props => [];
}

class PriceListShopStateInitial extends PriceListShopState {}

class PriceListShopStateLoading extends PriceListShopState {}

class PriceListShopStateFetch extends PriceListShopState {
  final List<ModelPriceListShop> priceList;
  final bool isActivating;
  final bool isUpdating;
  final int currentPage;
  final int pageSize;
  final int totalItem;
  final String search;
  final bool isLoadingMore;
  final String loadMoreError;

  const PriceListShopStateFetch({
    required this.priceList,
    this.isActivating = false,
    this.isUpdating = false,
    this.currentPage = 0,
    this.pageSize = ClientConstant.defaultPageSize,
    this.totalItem = 0,
    this.search = '',
    this.isLoadingMore = false,
    this.loadMoreError = '',
  });

  bool get hasMore => priceList.length < totalItem;

  PriceListShopStateFetch copyWith({
    List<ModelPriceListShop>? priceList,
    bool? isActivating,
    bool? isUpdating,
    int? currentPage,
    int? pageSize,
    int? totalItem,
    String? search,
    bool? isLoadingMore,
    String? loadMoreError,
  }) {
    return PriceListShopStateFetch(
      priceList: priceList ?? this.priceList,
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
    priceList,
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

class PriceListShopStateError extends PriceListShopState {
  final String message;

  const PriceListShopStateError({required this.message});

  @override
  List<Object?> get props => [message];
}

class PriceListShopStateActionResult extends PriceListShopState {
  final String message;
  final bool isSuccess;

  const PriceListShopStateActionResult({
    required this.message,
    required this.isSuccess,
  });

  @override
  List<Object?> get props => [message, isSuccess];
}
