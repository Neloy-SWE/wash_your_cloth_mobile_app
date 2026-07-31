/* 
Created by Neloy on 31 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/client/client_constant.dart';
import '../../../../../../data/model/model_shop_details.dart';
import '../../../../../../data/repository/repository_shop.dart';
import '../../../../../../data/use_case/use_case_generic.dart';

part 'shop_details_user_event.dart';

part 'shop_details_user_state.dart';

class ShopDetailsUserBloc
    extends Bloc<ShopDetailsUserEvent, ShopDetailsUserState> {
  final IRepositoryShop repositoryShop;

  ShopDetailsUserBloc({required this.repositoryShop})
    : super(ShopDetailsUserStateInitial()) {
    on<ShopDetailsUserEventFetch>(_onShopDetailsUserEventFetch);
  }

  Future<void> _onShopDetailsUserEventFetch(
    ShopDetailsUserEventFetch event,
    Emitter<ShopDetailsUserState> emit,
  ) async {
    emit(ShopDetailsUserStateLoading());
    try {
      UseCaseGeneric<ModelShopDetails> useCaseShopDetails = await repositoryShop
          .getShopDetailsUser(shopId: event.shopId);
      if (useCaseShopDetails.isSuccess) {
        emit(
          ShopDetailsUserStateFetch(shopDetailsUser: useCaseShopDetails.data!),
        );
      } else {
        emit(ShopDetailsUserStateResult(message: useCaseShopDetails.message!));
      }
    } catch (e) {
      emit(ShopDetailsUserStateResult(message: ClientConstant.serverError));
    }
  }
}
