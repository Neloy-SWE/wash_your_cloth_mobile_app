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

  const PriceListShopStateFetch({
    required this.priceList,
    this.isActivating = false,
    this.isUpdating = false,
  });

  PriceListShopStateFetch copyWith({
    List<ModelPriceListShop>? priceList,
    bool? isActivating,
    bool? isUpdating,
  }) {
    return PriceListShopStateFetch(
      priceList: priceList ?? this.priceList,
      isActivating: isActivating ?? this.isActivating,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }

  @override
  List<Object?> get props => [priceList, isActivating];
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