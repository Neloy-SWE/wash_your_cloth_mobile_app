/* 
Created by Neloy on 02 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../data/client/client_constant.dart';
import '../../../../../../../data/model/model_price_list_shop.dart';
import '../../../../../../../data/repository/repository_shop_inventory.dart';
import '../../../../../../../data/use_case/use_case_generic.dart';
import '../../../../../../../utilities/app_validator.dart';

part 'price_list_shop_event.dart';

part 'price_list_shop_state.dart';

class PriceListShopBloc extends Bloc<PriceListShopEvent, PriceListShopState> {
  static const int _pageSize = ClientConstant.defaultPageSize;
  // A fresh fetch invalidates any outstanding load-more response.
  int _listRequestGeneration = 0;
  final IRepositoryShopInventory repositoryShopInventory;

  PriceListShopBloc({required this.repositoryShopInventory})
    : super(PriceListShopStateInitial()) {
    on<PriceListShopEventFetch>(
      _onPriceListShopEventFetch,
      transformer: restartable(),
    );
    on<PriceListShopEventLoadMore>(_onLoadMore, transformer: droppable());
    on<PriceListShopEventActivation>(
      _onPriceListShopEventActivation,
      transformer: droppable(),
    );
    on<PriceListShopEventUpdate>(
      _onPriceListShopEventUpdate,
      transformer: sequential(),
    );
  }

  Future<void> _onPriceListShopEventFetch(
    PriceListShopEventFetch event,
    Emitter<PriceListShopState> emit,
  ) async {
    final generation = ++_listRequestGeneration;
    final query =
        (event.query ??
                (state is PriceListShopStateFetch
                    ? (state as PriceListShopStateFetch).search
                    : ''))
            .trim();
    if (event.debounce) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (emit.isDone) return;
    }
    if (!event.debounce) emit(PriceListShopStateLoading());
    try {
      final result = await repositoryShopInventory.getPriceListShop(
        currentPage: 0,
        pageSize: _pageSize,
        search: query,
      );
      if (emit.isDone || generation != _listRequestGeneration) return;
      if (result.isSuccess && result.data != null) {
        final page = result.data!;
        emit(
          PriceListShopStateFetch(
            priceList: page.items,
            currentPage: page.currentPage,
            pageSize: page.pageSize,
            totalItem: page.totalItem,
            search: query,
          ),
        );
      } else {
        emit(
          PriceListShopStateError(
            message: result.message ?? ClientConstant.serverError,
          ),
        );
      }
    } catch (e) {
      if (emit.isDone || generation != _listRequestGeneration) return;
      emit(const PriceListShopStateError(message: ClientConstant.serverError));
    }
  }

  Future<void> _onLoadMore(
    PriceListShopEventLoadMore event,
    Emitter<PriceListShopState> emit,
  ) async {
    if (state is! PriceListShopStateFetch) return;
    final current = state as PriceListShopStateFetch;
    if (current.isLoadingMore || !current.hasMore) return;
    final generation = _listRequestGeneration;
    emit(current.copyWith(isLoadingMore: true, loadMoreError: ''));
    final result = await repositoryShopInventory.getPriceListShop(
      currentPage: current.currentPage + 1,
      pageSize: current.pageSize,
      search: current.search,
    );
    if (emit.isDone ||
        generation != _listRequestGeneration ||
        state is! PriceListShopStateFetch) {
      return;
    }
    final latest = state as PriceListShopStateFetch;
    if (result.isSuccess && result.data != null) {
      final page = result.data!;
      emit(
        latest.copyWith(
          priceList: [...latest.priceList, ...page.items],
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

  Future<void> _onPriceListShopEventActivation(
    PriceListShopEventActivation event,
    Emitter<PriceListShopState> emit,
  ) async {
    // Preserve current list if state is already loaded
    if (state is! PriceListShopStateFetch) return;
    final currentState = state as PriceListShopStateFetch;

    // Set activating flag without clearing list
    emit(currentState.copyWith(isActivating: true));

    try {
      UseCaseGeneric activation = await repositoryShopInventory.priceActivation(
        priceId: event.priceId,
      );

      if (activation.isSuccess) {
        // Optimistically update target item in list locally
        // final updatedList = currentList.map((item) {
        //   if (item.id == event.priceId) {
        //     return item.copyWith(isActive: !item.isActive);
        //   }
        //   return item;
        // }).toList();

        // Find index and update directly
        final latestState = state;
        final currentList = latestState is PriceListShopStateFetch
            ? latestState.priceList
            : currentState.priceList;
        final index = currentList.indexWhere(
          (item) => item.id == event.priceId,
        );
        if (index != -1) {
          final updatedList = List<ModelPriceListShop>.from(currentList);
          updatedList[index] = updatedList[index].copyWith(
            isActive: !updatedList[index].isActive,
          );

          emit(
            PriceListShopStateActionResult(
              message: activation.message!,
              isSuccess: activation.isSuccess,
            ),
          );

          // Re-emit updated list immediately
          if (latestState is PriceListShopStateFetch) {
            emit(
              latestState.copyWith(priceList: updatedList, isActivating: false),
            );
          } else {
            emit(latestState);
          }
        } else {
          final latestState = state;
          emit(
            PriceListShopStateActionResult(
              message: AppValidator.validatorInvalidPrice,
              isSuccess: false,
            ),
          );
          // Restore previous state with original list
          if (latestState is PriceListShopStateFetch) {
            emit(latestState.copyWith(isActivating: false));
          } else {
            emit(latestState);
          }
        }

        // Emit success message side-effect
      } else {
        final latestState = state;
        emit(
          PriceListShopStateActionResult(
            message: activation.message!,
            isSuccess: activation.isSuccess,
          ),
        );
        // Restore previous state with original list
        if (latestState is PriceListShopStateFetch) {
          emit(latestState.copyWith(isActivating: false));
        } else {
          emit(latestState);
        }
      }
    } catch (e) {
      final latestState = state;
      emit(
        const PriceListShopStateActionResult(
          message: ClientConstant.serverError,
          isSuccess: false,
        ),
      );
      if (latestState is PriceListShopStateFetch) {
        emit(latestState.copyWith(isActivating: false));
      } else {
        emit(latestState);
      }
    }
  }

  Future<void> _onPriceListShopEventUpdate(
    PriceListShopEventUpdate event,
    Emitter<PriceListShopState> emit,
  ) async {
    try {
      if (state is! PriceListShopStateFetch) return;
      final currentState = state as PriceListShopStateFetch;
      final currentList = currentState.priceList;

      final index = currentList.indexWhere((item) => item.id == event.priceId);
      if (index != -1) {
        final updatedList = List<ModelPriceListShop>.from(currentList);
        updatedList[index] = updatedList[index].copyWith(
          price: event.price,
          discountPrice: event.discountPrice,
          ironPressPrice: event.ironPressPrice,
        );

        emit(currentState.copyWith(priceList: updatedList, isUpdating: true));
      } else {
        emit(
          PriceListShopStateActionResult(
            message: AppValidator.validatorInvalidPrice,
            isSuccess: false,
          ),
        );
      }
    } catch (e) {
      emit(
        const PriceListShopStateActionResult(
          message: ClientConstant.serverError,
          isSuccess: false,
        ),
      );
    }
  }
}
