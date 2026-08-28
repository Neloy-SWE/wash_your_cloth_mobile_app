/* 
Created by Neloy on 31 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_price_list_user.dart';

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
      final results = await Future.wait([
        repositoryShop.getShopDetailsUser(shopId: event.shopId),
        repositoryShop.getPriceListUser(shopId: event.shopId),
      ]);

      final useCaseShopDetails = results[0] as UseCaseGeneric<ModelShopDetails>;
      final useCasePriceList =
          results[1] as UseCaseGeneric<List<ModelPriceListUser>>;

      if (useCaseShopDetails.isSuccess && useCasePriceList.isSuccess) {
        emit(
          ShopDetailsUserStateFetch(
            shopDetailsUser: useCaseShopDetails.data!,
            priceList: useCasePriceList.data!,
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
      emit(ShopDetailsUserStateResult(message: ClientConstant.serverError));
    }
  }
}
