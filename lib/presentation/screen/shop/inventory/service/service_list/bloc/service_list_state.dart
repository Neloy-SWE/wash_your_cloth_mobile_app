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
  final int currentPage;
  final int pageSize;
  final int totalItem;
  final String search;
  final bool isLoadingMore;
  final String loadMoreError;

  const ServiceListStateFetch({
    required this.serviceList,
    this.isActivating = false,
    this.isUpdating = false,
    this.currentPage = 0,
    this.pageSize = ClientConstant.defaultPageSize,
    this.totalItem = 0,
    this.search = '',
    this.isLoadingMore = false,
    this.loadMoreError = '',
  });

  bool get hasMore => serviceList.length < totalItem;

  ServiceListStateFetch copyWith({
    List<ModelServiceList>? serviceList,
    bool? isActivating,
    bool? isUpdating,
    int? currentPage,
    int? pageSize,
    int? totalItem,
    String? search,
    bool? isLoadingMore,
    String? loadMoreError,
  }) {
    return ServiceListStateFetch(
      serviceList: serviceList ?? this.serviceList,
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
    serviceList,
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
