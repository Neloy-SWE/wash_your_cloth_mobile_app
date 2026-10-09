/* 
Created by Neloy on 09 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../data/client/client_constant.dart';
import '../../../../../../../data/repository/repository_shop_inventory.dart';
import '../../../../../../../data/request/request_update_price.dart';
import '../../../../../../../data/use_case/use_case_generic.dart';

part 'price_update_event.dart';

part 'price_update_state.dart';

class PriceUpdateBloc extends Bloc<PriceUpdateEvent, PriceUpdateState> {
  final IRepositoryShopInventory repositoryInventory;

  PriceUpdateBloc({required this.repositoryInventory})
    : super(PriceUpdateStateInitial()) {
    on<PriceUpdateEventSubmit>(_onPriceUpdateEventSubmit);
  }

  Future<void> _onPriceUpdateEventSubmit(
    PriceUpdateEventSubmit event,
    Emitter<PriceUpdateState> emit,
  ) async {
    emit(PriceUpdateStateLoading());
    try {
      RequestUpdatePrice updatePrice = RequestUpdatePrice(
        price: event.price,
        discountPrice: event.discountPrice,
        ironPressPrice: event.ironPressPrice,
      );
      UseCaseGeneric useCaseGeneric = await repositoryInventory.priceUpdate(
        updatePrice: updatePrice,
        priceId: event.priceId,
      );
      emit(
        PriceUpdateStateResult(
          message: useCaseGeneric.message!,
          isNavigate: useCaseGeneric.isSuccess,
        ),
      );
    } catch (e) {
      emit(
        PriceUpdateStateResult(
          message: ClientConstant.serverError,
          isNavigate: false,
        ),
      );
    }
  }
}
