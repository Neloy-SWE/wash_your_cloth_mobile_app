/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/repository/repository_order.dart';

import '../../../../../../data/client/client_constant.dart';
import '../../../../../../data/model/model_order_list.dart';

part 'order_list_shop_event.dart';

part 'order_list_shop_state.dart';

class OrderListShopBloc extends Bloc<OrderListShopEvent, OrderListShopState> {
  static const int _pageSize = ClientConstant.defaultPageSize;
  // A fresh fetch invalidates any outstanding load-more response.
  int _listRequestGeneration = 0;
  final IRepositoryOrder repositoryOrder;

  OrderListShopBloc({required this.repositoryOrder})
    : super(OrderListShopStateInitial()) {
    on<OrderListShopEventFetch>(
      _onOrderListShopEventFetch,
      transformer: restartable(),
    );
    on<OrderListShopEventLoadMore>(_onLoadMore, transformer: droppable());
  }

  Future<void> _onOrderListShopEventFetch(
    OrderListShopEventFetch event,
    Emitter<OrderListShopState> emit,
  ) async {
    final generation = ++_listRequestGeneration;
    final query =
        (event.query ??
                (state is OrderListShopStateFetch
                    ? (state as OrderListShopStateFetch).search
                    : ''))
            .trim();
    if (event.debounce) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (emit.isDone) return;
    }
    if (!event.debounce) emit(OrderListShopStateLoading());
    try {
      final result = await repositoryOrder.getOrderList(
        currentPage: 0,
        pageSize: _pageSize,
        search: query,
      );
      if (emit.isDone || generation != _listRequestGeneration) return;
      if (result.isSuccess && result.data != null) {
        final page = result.data!;
        emit(
          OrderListShopStateFetch(
            orderList: page.items,
            currentPage: page.currentPage,
            pageSize: page.pageSize,
            totalItem: page.totalItem,
            search: query,
          ),
        );
      } else {
        emit(
          OrderListShopStateResult(
            message: result.message ?? ClientConstant.serverError,
          ),
        );
      }
    } catch (e) {
      if (emit.isDone || generation != _listRequestGeneration) return;
      emit(OrderListShopStateResult(message: ClientConstant.serverError));
    }
  }

  Future<void> _onLoadMore(
    OrderListShopEventLoadMore event,
    Emitter<OrderListShopState> emit,
  ) async {
    if (state is! OrderListShopStateFetch) return;
    final current = state as OrderListShopStateFetch;
    if (current.isLoadingMore || !current.hasMore) return;
    final generation = _listRequestGeneration;
    emit(current.copyWith(isLoadingMore: true, loadMoreError: ''));
    final result = await repositoryOrder.getOrderList(
      currentPage: current.currentPage + 1,
      pageSize: current.pageSize,
      search: current.search,
    );
    if (emit.isDone ||
        generation != _listRequestGeneration ||
        state is! OrderListShopStateFetch) {
      return;
    }
    final latest = state as OrderListShopStateFetch;
    if (result.isSuccess && result.data != null) {
      final page = result.data!;
      emit(
        latest.copyWith(
          orderList: [...latest.orderList, ...page.items],
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
