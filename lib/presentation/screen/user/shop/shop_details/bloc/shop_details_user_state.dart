/* 
Created by Neloy on 31 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'shop_details_user_bloc.dart';

sealed class ShopDetailsUserState extends Equatable {
  const ShopDetailsUserState();

  @override
  List<Object?> get props => [];
}

class ShopDetailsUserStateInitial extends ShopDetailsUserState {}

class ShopDetailsUserStateLoading extends ShopDetailsUserState {}

class ShopDetailsUserStateFetch extends ShopDetailsUserState {
  final ModelShopDetails shopDetailsUser;
  final List<ModelPriceListUser> priceList;
  final String shopId;
  final int currentPage;
  final int pageSize;
  final int totalItem;
  final String search;
  final bool isLoadingMore;
  final String loadMoreError;

  const ShopDetailsUserStateFetch({
    required this.shopDetailsUser,
    required this.priceList,
    required this.shopId,
    this.currentPage = 0,
    this.pageSize = ClientConstant.defaultPageSize,
    this.totalItem = 0,
    this.search = '',
    this.isLoadingMore = false,
    this.loadMoreError = '',
  });

  bool get hasMore => priceList.length < totalItem;

  ShopDetailsUserStateFetch copyWith({
    ModelShopDetails? shopDetailsUser,
    List<ModelPriceListUser>? priceList,
    String? shopId,
    int? currentPage,
    int? pageSize,
    int? totalItem,
    String? search,
    bool? isLoadingMore,
    String? loadMoreError,
  }) => ShopDetailsUserStateFetch(
    shopDetailsUser: shopDetailsUser ?? this.shopDetailsUser,
    priceList: priceList ?? this.priceList,
    shopId: shopId ?? this.shopId,
    currentPage: currentPage ?? this.currentPage,
    pageSize: pageSize ?? this.pageSize,
    totalItem: totalItem ?? this.totalItem,
    search: search ?? this.search,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    loadMoreError: loadMoreError ?? this.loadMoreError,
  );

  @override
  List<Object?> get props => [
    shopDetailsUser,
    priceList,
    shopId,
    currentPage,
    pageSize,
    totalItem,
    search,
    isLoadingMore,
    loadMoreError,
  ];
}

class ShopDetailsUserStateResult extends ShopDetailsUserState {
  final String message;

  const ShopDetailsUserStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
