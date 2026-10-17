/* 
Created by Neloy on 14 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../data/client/client_constant.dart';
import '../../../../../../../data/model/model_item_list.dart';
import '../../../../../../../data/repository/repository_shop_inventory.dart';
import '../../../../../../../data/use_case/use_case_generic.dart';
import '../../../../../../../utilities/app_validator.dart';

part 'item_list_event.dart';

part 'item_list_state.dart';

class ItemListBloc extends Bloc<ItemListEvent, ItemListState> {
  final IRepositoryShopInventory repositoryShopInventory;

  ItemListBloc({required this.repositoryShopInventory})
    : super(ItemListStateInitial()) {
    on<ItemListEventFetch>(_onItemListEventFetch);
    on<ItemListEventActivation>(_onItemListEventActivation);
    on<ItemListEventUpdate>(_onItemListEventUpdate);
  }

  Future<void> _onItemListEventFetch(
    ItemListEventFetch event,
    Emitter<ItemListState> emit,
  ) async {
    emit(ItemListStateLoading());
    try {
      UseCaseGeneric<List<ModelItemList>> useCaseItemList =
          await repositoryShopInventory.getItemList();
      if (useCaseItemList.isSuccess) {
        emit(ItemListStateFetch(itemList: useCaseItemList.data!));
      } else {
        emit(ItemListStateError(message: useCaseItemList.message!));
      }
    } catch (e) {
      emit(const ItemListStateError(message: ClientConstant.serverError));
    }
  }

  Future<void> _onItemListEventActivation(
    ItemListEventActivation event,
    Emitter<ItemListState> emit,
  ) async {
    if (state is! ItemListStateFetch) return;
    final currentState = state as ItemListStateFetch;
    final currentList = currentState.itemList;

    emit(currentState.copyWith(isActivating: true));

    try {
      UseCaseGeneric activation = await repositoryShopInventory
          .itemActivation(itemId: event.itemId);

      if (activation.isSuccess) {
        final index = currentList.indexWhere(
          (item) => item.id == event.itemId,
        );
        if (index != -1) {
          final updatedList = List<ModelItemList>.from(currentList);
          updatedList[index] = updatedList[index].copyWith(
            isActive: !updatedList[index].isActive,
          );

          emit(
            ItemListStateActionResult(
              message: activation.message!,
              isSuccess: activation.isSuccess,
            ),
          );

          emit(
            ItemListStateFetch(
              itemList: updatedList,
              isActivating: false,
            ),
          );
        } else {
          emit(
            ItemListStateActionResult(
              message: AppValidator.validatorInvalidItem,
              isSuccess: false,
            ),
          );
          emit(currentState.copyWith(isActivating: false));
        }
      } else {
        emit(
          ItemListStateActionResult(
            message: activation.message!,
            isSuccess: activation.isSuccess,
          ),
        );
        emit(currentState.copyWith(isActivating: false));
      }
    } catch (e) {
      emit(
        const ItemListStateActionResult(
          message: ClientConstant.serverError,
          isSuccess: false,
        ),
      );
      emit(currentState.copyWith(isActivating: false));
    }
  }

  Future<void> _onItemListEventUpdate(
    ItemListEventUpdate event,
    Emitter<ItemListState> emit,
  ) async {
    try {
      if (state is! ItemListStateFetch) return;
      final currentState = state as ItemListStateFetch;
      final currentList = currentState.itemList;

      final index = currentList.indexWhere(
        (item) => item.id == event.itemId,
      );
      if (index != -1) {
        final updatedList = List<ModelItemList>.from(currentList);
        updatedList[index] = updatedList[index].copyWith(
          itemName: event.itemName,
        );

        emit(ItemListStateFetch(itemList: updatedList, isUpdating: true));
      } else {
        emit(
          ItemListStateActionResult(
            message: AppValidator.validatorInvalidItem,
            isSuccess: false,
          ),
        );
      }
    } catch (e) {
      emit(
        const ItemListStateActionResult(
          message: ClientConstant.serverError,
          isSuccess: false,
        ),
      );
    }
  }
}
