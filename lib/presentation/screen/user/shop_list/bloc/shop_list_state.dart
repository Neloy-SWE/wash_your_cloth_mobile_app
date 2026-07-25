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
  final List<ModelSopList> shopList;

  const ShopListStateFetch({required this.shopList});

  @override
  List<Object?> get props => [shopList];
}

class ShopListStateResult extends ShopListState {
  final String message;

  const ShopListStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
