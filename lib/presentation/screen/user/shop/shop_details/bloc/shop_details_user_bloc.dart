/* 
Created by Neloy on 31 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_price_list_user.dart';

import '../../../../../../data/client/client_constant.dart';
import '../../../../../../data/model/model_shop_details.dart';
import '../../../../../../data/model/model_paged_list.dart';
import '../../../../../../data/repository/repository_shop.dart';
import '../../../../../../data/use_case/use_case_generic.dart';

part 'shop_details_user_event.dart';

part 'shop_details_user_state.dart';

class ShopDetailsUserBloc
    extends Bloc<ShopDetailsUserEvent, ShopDetailsUserState> {
  static const int _pageSize = ClientConstant.defaultPageSize;
  // A fresh fetch invalidates any outstanding load-more response.
  int _listRequestGeneration = 0;
  final IRepositoryShop repositoryShop;

  ShopDetailsUserBloc({required this.repositoryShop})
    : super(ShopDetailsUserStateInitial()) {
    on<ShopDetailsUserEventFetch>(
      _onShopDetailsUserEventFetch,
      transformer: restartable(),
    );
    on<ShopDetailsUserEventLoadMore>(_onLoadMore, transformer: droppable());
  }

  Future<void> _onShopDetailsUserEventFetch(
    ShopDetailsUserEventFetch event,
    Emitter<ShopDetailsUserState> emit,
  ) async {
    final generation = ++_listRequestGeneration;
    final query =
        (event.query ??
                (state is ShopDetailsUserStateFetch
                    ? (state as ShopDetailsUserStateFetch).search
                    : ''))
            .trim();
    if (event.debounce) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      if (emit.isDone) return;
    }
    if (!event.fetchDetails && state is ShopDetailsUserStateFetch) {
      final current = state as ShopDetailsUserStateFetch;
      emit(
        current.copyWith(
          currentPage: -1,
          totalItem: 0,
          search: query,
          isLoadingMore: false,
          loadMoreError: '',
        ),
      );
      final result = await repositoryShop.getPriceListUser(
        shopId: event.shopId,
        currentPage: 0,
        pageSize: _pageSize,
        search: query,
      );
      if (emit.isDone || generation != _listRequestGeneration) return;
      if (result.isSuccess && result.data != null) {
        final page = result.data!;
        emit(
          (state as ShopDetailsUserStateFetch).copyWith(
            priceList: page.items,
            currentPage: page.currentPage,
            pageSize: page.pageSize,
            totalItem: page.totalItem,
            search: query,
          ),
        );
      } else {
        emit(
          (state as ShopDetailsUserStateFetch).copyWith(
            priceList: const [],
            currentPage: -1,
            totalItem: 0,
            loadMoreError: result.message ?? ClientConstant.serverError,
          ),
        );
      }
      return;
    }
    emit(ShopDetailsUserStateLoading());
    try {
      final results = await Future.wait([
        repositoryShop.getShopDetailsUser(shopId: event.shopId),
        repositoryShop.getPriceListUser(
          shopId: event.shopId,
          currentPage: 0,
          pageSize: _pageSize,
          search: query,
        ),
      ]);

      final useCaseShopDetails = results[0] as UseCaseGeneric<ModelShopDetails>;
      final useCasePriceList =
          results[1] as UseCaseGeneric<ModelPagedList<ModelPriceListUser>>;

      if (emit.isDone || generation != _listRequestGeneration) return;
      if (useCaseShopDetails.isSuccess && useCasePriceList.isSuccess) {
        final page = useCasePriceList.data!;
        emit(
          ShopDetailsUserStateFetch(
            shopDetailsUser: useCaseShopDetails.data!,
            priceList: page.items,
            shopId: event.shopId,
            currentPage: page.currentPage,
            pageSize: page.pageSize,
            totalItem: page.totalItem,
            search: query,
          ),
        );
      } else {
        // emit(ShopDetailsUserStateResult(message: useCaseShopDetails.message!));
        emit(
          ShopDetailsUserStateResult(
            message: !useCaseShopDetails.isSuccess
                ? useCaseShopDetails.message!
                : !useCasePriceList.isSuccess
                ? useCasePriceList.message!
                : ClientConstant.unableToGetDetails,
          ),
        );
      }
    } catch (e) {
      if (emit.isDone || generation != _listRequestGeneration) return;
      emit(ShopDetailsUserStateResult(message: ClientConstant.serverError));
    }
  }

  Future<void> _onLoadMore(
    ShopDetailsUserEventLoadMore event,
    Emitter<ShopDetailsUserState> emit,
  ) async {
    if (state is! ShopDetailsUserStateFetch) return;
    final current = state as ShopDetailsUserStateFetch;
    if (current.isLoadingMore || !current.hasMore) return;
    final generation = _listRequestGeneration;
    emit(current.copyWith(isLoadingMore: true, loadMoreError: ''));
    final result = await repositoryShop.getPriceListUser(
      shopId: current.shopId,
      currentPage: current.currentPage + 1,
      pageSize: current.pageSize,
      search: current.search,
    );
    if (emit.isDone ||
        generation != _listRequestGeneration ||
        state is! ShopDetailsUserStateFetch) {
      return;
    }
    final latest = state as ShopDetailsUserStateFetch;
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
}
