/* 
Created by Neloy on 02 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

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
  final IRepositoryShopInventory repositoryShopInventory;

  PriceListShopBloc({required this.repositoryShopInventory})
    : super(PriceListShopStateInitial()) {
    on<PriceListShopEventFetch>(_onPriceListShopEventFetch);
    on<PriceListShopEventActivation>(_onPriceListShopEventActivation);
    on<PriceListShopEventUpdate>(_onPriceListShopEventUpdate);
  }

  Future<void> _onPriceListShopEventFetch(
    PriceListShopEventFetch event,
    Emitter<PriceListShopState> emit,
  ) async {
    emit(PriceListShopStateLoading());
    try {
      UseCaseGeneric<List<ModelPriceListShop>> useCasePriceList =
          await repositoryShopInventory.getPriceListShop();
      if (useCasePriceList.isSuccess) {
        emit(PriceListShopStateFetch(priceList: useCasePriceList.data!));
      } else {
        emit(PriceListShopStateError(message: useCasePriceList.message!));
      }
    } catch (e) {
      emit(const PriceListShopStateError(message: ClientConstant.serverError));
    }
  }

  Future<void> _onPriceListShopEventActivation(
    PriceListShopEventActivation event,
    Emitter<PriceListShopState> emit,
  ) async {
    // Preserve current list if state is already loaded
    if (state is! PriceListShopStateFetch) return;
    final currentState = state as PriceListShopStateFetch;
    final currentList = currentState.priceList;

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
          emit(
            PriceListShopStateFetch(
              priceList: updatedList,
              isActivating: false,
            ),
          );
        } else {
          emit(
            PriceListShopStateActionResult(
              message: AppValidator.validatorInvalidPrice,
              isSuccess: false,
            ),
          );
          // Restore previous state with original list
          emit(currentState.copyWith(isActivating: false));
        }

        // Emit success message side-effect
      } else {
        emit(
          PriceListShopStateActionResult(
            message: activation.message!,
            isSuccess: activation.isSuccess,
          ),
        );
        // Restore previous state with original list
        emit(currentState.copyWith(isActivating: false));
      }
    } catch (e) {
      emit(
        const PriceListShopStateActionResult(
          message: ClientConstant.serverError,
          isSuccess: false,
        ),
      );
      emit(currentState.copyWith(isActivating: false));
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

        emit(PriceListShopStateFetch(priceList: updatedList, isUpdating: true));
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
