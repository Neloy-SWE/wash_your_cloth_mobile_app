/* 
Created by Neloy on 25 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_shop_list.dart';

import '../../../../../../data/client/client_constant.dart';
import '../../../../../../data/repository/repository_shop.dart';

part 'shop_list_event.dart';

part 'shop_list_state.dart';

class ShopListBloc extends Bloc<ShopListEvent, ShopListState> {
  static const int _pageSize = ClientConstant.defaultPageSize;
  // A fresh fetch invalidates any outstanding load-more response.
  int _listRequestGeneration = 0;
  final IRepositoryShop repositoryShop;

  ShopListBloc({required this.repositoryShop}) : super(ShopListStateInitial()) {
    on<ShopListEventFetch>(_onShopListEventFetch, transformer: restartable());
    on<ShopListEventLoadMore>(_onLoadMore, transformer: droppable());
  }

  Future<void> _onShopListEventFetch(
    ShopListEventFetch event,
    Emitter<ShopListState> emit,
  ) async {
    final generation = ++_listRequestGeneration;
    final query =
        (event.query ??
                (state is ShopListStateFetch
                    ? (state as ShopListStateFetch).search
                    : ''))
            .trim();
    if (event.debounce) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (emit.isDone) return;
    }
    if (!event.debounce) emit(ShopListStateLoading());
    try {
      final result = await repositoryShop.getShopList(
        currentPage: 0,
        pageSize: _pageSize,
        search: query,
      );
      if (emit.isDone || generation != _listRequestGeneration) return;
      if (result.isSuccess && result.data != null) {
        final page = result.data!;
        emit(
          ShopListStateFetch(
            shopList: page.items,
            currentPage: page.currentPage,
            pageSize: page.pageSize,
            totalItem: page.totalItem,
            search: query,
          ),
        );
      } else {
        emit(
          ShopListStateResult(
            message: result.message ?? ClientConstant.serverError,
          ),
        );
      }
    } catch (e) {
      if (emit.isDone || generation != _listRequestGeneration) return;
      emit(ShopListStateResult(message: ClientConstant.serverError));
    }
  }

  Future<void> _onLoadMore(
    ShopListEventLoadMore event,
    Emitter<ShopListState> emit,
  ) async {
    if (state is! ShopListStateFetch) return;
    final current = state as ShopListStateFetch;
    if (current.isLoadingMore || !current.hasMore) return;
    final generation = _listRequestGeneration;
    emit(current.copyWith(isLoadingMore: true, loadMoreError: ''));
    final result = await repositoryShop.getShopList(
      currentPage: current.currentPage + 1,
      pageSize: current.pageSize,
      search: current.search,
    );
    if (emit.isDone ||
        generation != _listRequestGeneration ||
        state is! ShopListStateFetch) {
      return;
    }
    final latest = state as ShopListStateFetch;
    if (result.isSuccess && result.data != null) {
      final page = result.data!;
      emit(
        latest.copyWith(
          shopList: [...latest.shopList, ...page.items],
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
}
