/* 
Created by Neloy on 14 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../data/client/client_constant.dart';
import '../../../../../../../data/model/model_item_list.dart';
import '../../../../../../../data/repository/repository_shop_inventory.dart';
import '../../../../../../../data/use_case/use_case_generic.dart';
import '../../../../../../../utilities/app_validator.dart';

part 'item_list_event.dart';

part 'item_list_state.dart';

class ItemListBloc extends Bloc<ItemListEvent, ItemListState> {
  static const int _pageSize = ClientConstant.defaultPageSize;
  // A fresh fetch invalidates any outstanding load-more response.
  int _listRequestGeneration = 0;
  final IRepositoryShopInventory repositoryShopInventory;

  ItemListBloc({required this.repositoryShopInventory})
    : super(ItemListStateInitial()) {
    on<ItemListEventFetch>(_onItemListEventFetch, transformer: restartable());
    on<ItemListEventLoadMore>(_onLoadMore, transformer: droppable());
    on<ItemListEventActivation>(
      _onItemListEventActivation,
      transformer: droppable(),
    );
    on<ItemListEventUpdate>(_onItemListEventUpdate, transformer: sequential());
  }

  Future<void> _onItemListEventFetch(
    ItemListEventFetch event,
    Emitter<ItemListState> emit,
  ) async {
    final generation = ++_listRequestGeneration;
    final query =
        (event.query ??
                (state is ItemListStateFetch
                    ? (state as ItemListStateFetch).search
                    : ''))
            .trim();
    if (event.debounce) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (emit.isDone) return;
    }
    if (!event.debounce) emit(ItemListStateLoading());
    try {
      final result = await repositoryShopInventory.getItemList(
        currentPage: 0,
        pageSize: _pageSize,
        search: query,
      );
      if (emit.isDone || generation != _listRequestGeneration) return;
      if (result.isSuccess && result.data != null) {
        final page = result.data!;
        emit(
          ItemListStateFetch(
            itemList: page.items,
            currentPage: page.currentPage,
            pageSize: page.pageSize,
            totalItem: page.totalItem,
            search: query,
          ),
        );
      } else {
        emit(
          ItemListStateError(
            message: result.message ?? ClientConstant.serverError,
          ),
        );
      }
    } catch (e) {
      if (emit.isDone || generation != _listRequestGeneration) return;
      emit(const ItemListStateError(message: ClientConstant.serverError));
    }
  }

  Future<void> _onLoadMore(
    ItemListEventLoadMore event,
    Emitter<ItemListState> emit,
  ) async {
    if (state is! ItemListStateFetch) return;
    final current = state as ItemListStateFetch;
    if (current.isLoadingMore || !current.hasMore) return;
    final generation = _listRequestGeneration;
    emit(current.copyWith(isLoadingMore: true, loadMoreError: ''));
    final result = await repositoryShopInventory.getItemList(
      currentPage: current.currentPage + 1,
      pageSize: current.pageSize,
      search: current.search,
    );
    if (emit.isDone ||
        generation != _listRequestGeneration ||
        state is! ItemListStateFetch) {
      return;
    }
    final latest = state as ItemListStateFetch;
    if (result.isSuccess && result.data != null) {
      final page = result.data!;
      emit(
        latest.copyWith(
          itemList: [...latest.itemList, ...page.items],
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

  Future<void> _onItemListEventActivation(
    ItemListEventActivation event,
    Emitter<ItemListState> emit,
  ) async {
    if (state is! ItemListStateFetch) return;
    final currentState = state as ItemListStateFetch;

    emit(currentState.copyWith(isActivating: true));

    try {
      UseCaseGeneric activation = await repositoryShopInventory.itemActivation(
        itemId: event.itemId,
      );

      if (activation.isSuccess) {
        final latestState = state;
        final currentList = latestState is ItemListStateFetch
            ? latestState.itemList
            : currentState.itemList;
        final index = currentList.indexWhere((item) => item.id == event.itemId);
        if (index != -1) {
          final updatedList = List<ModelItemList>.from(currentList);
          updatedList[index] = updatedList[index].copyWith(
            isActive: !updatedList[index].isActive,
          );

          emit(
            ItemListStateActionResult(
              message: activation.message!,
              isSuccess: activation.isSuccess,
            ),
          );

          if (latestState is ItemListStateFetch) {
            emit(
              latestState.copyWith(itemList: updatedList, isActivating: false),
            );
          } else {
            emit(latestState);
          }
        } else {
          final latestState = state;
          emit(
            ItemListStateActionResult(
              message: AppValidator.validatorInvalidItem,
              isSuccess: false,
            ),
          );
          if (latestState is ItemListStateFetch) {
            emit(latestState.copyWith(isActivating: false));
          } else {
            emit(latestState);
          }
        }
      } else {
        final latestState = state;
        emit(
          ItemListStateActionResult(
            message: activation.message!,
            isSuccess: activation.isSuccess,
          ),
        );
        if (latestState is ItemListStateFetch) {
          emit(latestState.copyWith(isActivating: false));
        } else {
          emit(latestState);
        }
      }
    } catch (e) {
      final latestState = state;
      emit(
        const ItemListStateActionResult(
          message: ClientConstant.serverError,
          isSuccess: false,
        ),
      );
      if (latestState is ItemListStateFetch) {
        emit(latestState.copyWith(isActivating: false));
      } else {
        emit(latestState);
      }
    }
  }

  Future<void> _onItemListEventUpdate(
    ItemListEventUpdate event,
    Emitter<ItemListState> emit,
  ) async {
    try {
      if (state is! ItemListStateFetch) return;
      final currentState = state as ItemListStateFetch;
      final currentList = currentState.itemList;

      final index = currentList.indexWhere((item) => item.id == event.itemId);
      if (index != -1) {
        final updatedList = List<ModelItemList>.from(currentList);
        updatedList[index] = updatedList[index].copyWith(
          itemName: event.itemName,
        );

        emit(currentState.copyWith(itemList: updatedList, isUpdating: true));
      } else {
        emit(
          ItemListStateActionResult(
            message: AppValidator.validatorInvalidItem,
            isSuccess: false,
          ),
        );
      }
    } catch (e) {
      emit(
        const ItemListStateActionResult(
          message: ClientConstant.serverError,
          isSuccess: false,
        ),
      );
    }
  }
}
