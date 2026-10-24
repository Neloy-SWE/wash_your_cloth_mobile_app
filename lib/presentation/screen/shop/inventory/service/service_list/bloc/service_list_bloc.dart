/* 
Created by Neloy on 10a October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../data/client/client_constant.dart';
import '../../../../../../../data/model/model_service_list.dart';
import '../../../../../../../data/repository/repository_shop_inventory.dart';
import '../../../../../../../data/use_case/use_case_generic.dart';
import '../../../../../../../utilities/app_validator.dart';

part 'service_list_event.dart';

part 'service_list_state.dart';

class ServiceListBloc extends Bloc<ServiceListEvent, ServiceListState> {
  static const int _pageSize = ClientConstant.defaultPageSize;
  // A fresh fetch invalidates any outstanding load-more response.
  int _listRequestGeneration = 0;
  final IRepositoryShopInventory repositoryShopInventory;

  ServiceListBloc({required this.repositoryShopInventory})
    : super(ServiceListStateInitial()) {
    on<ServiceListEventFetch>(
      _onServiceListEventFetch,
      transformer: restartable(),
    );
    on<ServiceListEventLoadMore>(_onLoadMore, transformer: droppable());
    on<ServiceListEventActivation>(
      _onServiceListEventActivation,
      transformer: droppable(),
    );
    on<ServiceListEventUpdate>(
      _onServiceListEventUpdate,
      transformer: sequential(),
    );
  }

  Future<void> _onServiceListEventFetch(
    ServiceListEventFetch event,
    Emitter<ServiceListState> emit,
  ) async {
    final generation = ++_listRequestGeneration;
    final query =
        (event.query ??
                (state is ServiceListStateFetch
                    ? (state as ServiceListStateFetch).search
                    : ''))
            .trim();
    if (event.debounce) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (emit.isDone) return;
    }
    if (!event.debounce) emit(ServiceListStateLoading());
    try {
      final result = await repositoryShopInventory.getServiceList(
        currentPage: 0,
        pageSize: _pageSize,
        search: query,
      );
      if (emit.isDone || generation != _listRequestGeneration) return;
      if (result.isSuccess && result.data != null) {
        final page = result.data!;
        emit(
          ServiceListStateFetch(
            serviceList: page.items,
            currentPage: page.currentPage,
            pageSize: page.pageSize,
            totalItem: page.totalItem,
            search: query,
          ),
        );
      } else {
        emit(
          ServiceListStateError(
            message: result.message ?? ClientConstant.serverError,
          ),
        );
      }
    } catch (e) {
      if (emit.isDone || generation != _listRequestGeneration) return;
      emit(const ServiceListStateError(message: ClientConstant.serverError));
    }
  }

  Future<void> _onLoadMore(
    ServiceListEventLoadMore event,
    Emitter<ServiceListState> emit,
  ) async {
    if (state is! ServiceListStateFetch) return;
    final current = state as ServiceListStateFetch;
    if (current.isLoadingMore || !current.hasMore) return;
    final generation = _listRequestGeneration;
    emit(current.copyWith(isLoadingMore: true, loadMoreError: ''));
    final result = await repositoryShopInventory.getServiceList(
      currentPage: current.currentPage + 1,
      pageSize: current.pageSize,
      search: current.search,
    );
    if (emit.isDone ||
        generation != _listRequestGeneration ||
        state is! ServiceListStateFetch) {
      return;
    }
    final latest = state as ServiceListStateFetch;
    if (result.isSuccess && result.data != null) {
      final page = result.data!;
      emit(
        latest.copyWith(
          serviceList: [...latest.serviceList, ...page.items],
          currentPage: page.currentPage,
          pageSize: page.pageSize,
          totalItem: page.totalItem,
          isLoadingMore: false,
          loadMoreError: '',
        ),
      );
    } else {
      emit(
        latest.copyWith(
          isLoadingMore: false,
          loadMoreError: result.message ?? ClientConstant.serverError,
        ),
      );
    }
  }

  Future<void> _onServiceListEventActivation(
    ServiceListEventActivation event,
    Emitter<ServiceListState> emit,
  ) async {
    if (state is! ServiceListStateFetch) return;
    final currentState = state as ServiceListStateFetch;

    emit(currentState.copyWith(isActivating: true));

    try {
      UseCaseGeneric activation = await repositoryShopInventory
          .serviceActivation(serviceId: event.serviceId);

      if (activation.isSuccess) {
        final latestState = state;
        final currentList = latestState is ServiceListStateFetch
            ? latestState.serviceList
            : currentState.serviceList;
        final index = currentList.indexWhere(
          (item) => item.id == event.serviceId,
        );
        if (index != -1) {
          final updatedList = List<ModelServiceList>.from(currentList);
          updatedList[index] = updatedList[index].copyWith(
            isActive: !updatedList[index].isActive,
          );

          emit(
            ServiceListStateActionResult(
              message: activation.message!,
              isSuccess: activation.isSuccess,
            ),
          );

          if (latestState is ServiceListStateFetch) {
            emit(
              latestState.copyWith(
                serviceList: updatedList,
                isActivating: false,
              ),
            );
          } else {
            emit(latestState);
          }
        } else {
          final latestState = state;
          emit(
            ServiceListStateActionResult(
              message: AppValidator.validatorInvalidService,
              isSuccess: false,
            ),
          );
          if (latestState is ServiceListStateFetch) {
            emit(latestState.copyWith(isActivating: false));
          } else {
            emit(latestState);
          }
        }
      } else {
        final latestState = state;
        emit(
          ServiceListStateActionResult(
            message: activation.message!,
            isSuccess: activation.isSuccess,
          ),
        );
        if (latestState is ServiceListStateFetch) {
          emit(latestState.copyWith(isActivating: false));
        } else {
          emit(latestState);
        }
      }
    } catch (e) {
      final latestState = state;
      emit(
        const ServiceListStateActionResult(
          message: ClientConstant.serverError,
          isSuccess: false,
        ),
      );
      if (latestState is ServiceListStateFetch) {
        emit(latestState.copyWith(isActivating: false));
      } else {
        emit(latestState);
      }
    }
  }

  Future<void> _onServiceListEventUpdate(
    ServiceListEventUpdate event,
    Emitter<ServiceListState> emit,
  ) async {
    try {
      if (state is! ServiceListStateFetch) return;
      final currentState = state as ServiceListStateFetch;
      final currentList = currentState.serviceList;

      final index = currentList.indexWhere(
        (item) => item.id == event.serviceId,
      );
      if (index != -1) {
        final updatedList = List<ModelServiceList>.from(currentList);
        updatedList[index] = updatedList[index].copyWith(
          serviceName: event.serviceName,
          description: event.description,
        );

        emit(currentState.copyWith(serviceList: updatedList, isUpdating: true));
      } else {
        emit(
          ServiceListStateActionResult(
            message: AppValidator.validatorInvalidService,
            isSuccess: false,
          ),
        );
      }
    } catch (e) {
      emit(
        const ServiceListStateActionResult(
          message: ClientConstant.serverError,
          isSuccess: false,
        ),
      );
    }
  }
}
