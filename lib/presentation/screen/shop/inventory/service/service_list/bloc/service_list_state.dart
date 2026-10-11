/* 
Created by Neloy on 10 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'service_list_bloc.dart';

sealed class ServiceListState extends Equatable {
  const ServiceListState();

  @override
  List<Object?> get props => [];
}

class ServiceListStateInitial extends ServiceListState {}

class ServiceListStateLoading extends ServiceListState {}

class ServiceListStateFetch extends ServiceListState {
  final List<ModelServiceList> serviceList;
  final bool isActivating;
  final bool isUpdating;

  const ServiceListStateFetch({
    required this.serviceList,
    this.isActivating = false,
    this.isUpdating = false,
  });

  ServiceListStateFetch copyWith({
    List<ModelServiceList>? serviceList,
    bool? isActivating,
    bool? isUpdating,
  }) {
    return ServiceListStateFetch(
      serviceList: serviceList ?? this.serviceList,
      isActivating: isActivating ?? this.isActivating,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }

  @override
  List<Object?> get props => [serviceList, isActivating];
}

class ServiceListStateError extends ServiceListState {
  final String message;

  const ServiceListStateError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServiceListStateActionResult extends ServiceListState {
  final String message;
  final bool isSuccess;

  const ServiceListStateActionResult({
    required this.message,
    required this.isSuccess,
  });

  @override
  List<Object?> get props => [message, isSuccess];
}
