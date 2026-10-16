/* 
Created by Neloy on 16 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'price_add_bloc.dart';

sealed class PriceAddState extends Equatable {
  const PriceAddState();

  @override
  List<Object?> get props => [];
}

class PriceAddStateInitial extends PriceAddState {}

class PriceAddStateLoading extends PriceAddState {}

class PriceAddStateDropdownDataLoaded extends PriceAddState {
  final List<ModelItemList> itemList;
  final List<ModelServiceList> serviceList;
  final bool isNavigate;
  final String message;

  const PriceAddStateDropdownDataLoaded({
    required this.itemList,
    required this.serviceList,
    required this.isNavigate,
    required this.message,
  });

  PriceAddStateDropdownDataLoaded copyWith({
    List<ModelItemList>? itemList,
    List<ModelServiceList>? serviceList,
    bool? isNavigate,
    String? message,
  }) {
    return PriceAddStateDropdownDataLoaded(
      itemList: itemList ?? this.itemList,
      serviceList: serviceList ?? this.serviceList,
      message: message ?? this.message,
      isNavigate: isNavigate ?? this.isNavigate,
    );
  }

  @override
  List<Object?> get props => [itemList, serviceList, message, isNavigate];
}
