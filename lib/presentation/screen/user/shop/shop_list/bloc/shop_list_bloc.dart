/* 
Created by Neloy on 25 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_shop_list.dart';

import '../../../../../../data/client/client_constant.dart';
import '../../../../../../data/repository/repository_shop.dart';
import '../../../../../../data/use_case/use_case_generic.dart';

part 'shop_list_event.dart';

part 'shop_list_state.dart';

class ShopListBloc extends Bloc<ShopListEvent, ShopListState> {
  final IRepositoryShop repositoryShop;

  ShopListBloc({required this.repositoryShop}) : super(ShopListStateInitial()) {
    on<ShopListEventFetch>(_onShopListEventFetch);
  }

  Future<void> _onShopListEventFetch(
    ShopListEventFetch event,
    Emitter<ShopListState> emit,
  ) async {
    emit(ShopListStateLoading());
    try {
      UseCaseGeneric<List<ModelShopList>> useCaseShopList = await repositoryShop
          .getShopList();
      if (useCaseShopList.isSuccess) {
        emit(ShopListStateFetch(shopList: useCaseShopList.data!));
      } else {
        emit(ShopListStateResult(message: useCaseShopList.message!));
      }
    } catch (e) {
      emit(ShopListStateResult(message: ClientConstant.serverError));
    }
  }
}
