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

part 'order_list_user_event.dart';

part 'order_list_user_state.dart';

class OrderListUserBloc extends Bloc<OrderListUserEvent, OrderListUserState> {
  static const int _pageSize = ClientConstant.defaultPageSize;
  // A fresh fetch invalidates any outstanding load-more response.
  int _listRequestGeneration = 0;
  final IRepositoryOrder repositoryOrder;

  OrderListUserBloc({required this.repositoryOrder})
    : super(OrderListUserStateInitial()) {
    on<OrderListUserEventFetch>(
      _onOrderListUserEventFetch,
      transformer: restartable(),
    );
    on<OrderListUserEventLoadMore>(_onLoadMore, transformer: droppable());
  }

  Future<void> _onOrderListUserEventFetch(
    OrderListUserEventFetch event,
    Emitter<OrderListUserState> emit,
  ) async {
    final generation = ++_listRequestGeneration;
    final query =
        (event.query ??
                (state is OrderListUserStateFetch
                    ? (state as OrderListUserStateFetch).search
                    : ''))
            .trim();
    if (event.debounce) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (emit.isDone) return;
    }
    if (!event.debounce) emit(OrderListUserStateLoading());
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
          OrderListUserStateFetch(
            orderList: page.items,
            currentPage: page.currentPage,
            pageSize: page.pageSize,
            totalItem: page.totalItem,
            search: query,
          ),
        );
      } else {
        emit(
          OrderListUserStateResult(
            message: result.message ?? ClientConstant.serverError,
          ),
        );
      }
    } catch (e) {
      if (emit.isDone || generation != _listRequestGeneration) return;
      emit(OrderListUserStateResult(message: ClientConstant.serverError));
    }
  }

  Future<void> _onLoadMore(
    OrderListUserEventLoadMore event,
    Emitter<OrderListUserState> emit,
  ) async {
    if (state is! OrderListUserStateFetch) return;
    final current = state as OrderListUserStateFetch;
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
        state is! OrderListUserStateFetch) {
      return;
    }
    final latest = state as OrderListUserStateFetch;
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
