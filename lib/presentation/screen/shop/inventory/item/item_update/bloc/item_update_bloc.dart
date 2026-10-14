/* 
Created by Neloy on 14 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../data/client/client_constant.dart';
import '../../../../../../../data/repository/repository_shop_inventory.dart';
import '../../../../../../../data/request/request_item.dart';
import '../../../../../../../data/use_case/use_case_generic.dart';

part 'item_update_event.dart';

part 'item_update_state.dart';

class ItemUpdateBloc extends Bloc<ItemUpdateEvent, ItemUpdateState> {
  final IRepositoryShopInventory repositoryInventory;

  ItemUpdateBloc({required this.repositoryInventory})
    : super(ItemUpdateStateInitial()) {
    on<ItemUpdateEventSubmit>(_onItemUpdateEventSubmit);
  }

  Future<void> _onItemUpdateEventSubmit(
    ItemUpdateEventSubmit event,
    Emitter<ItemUpdateState> emit,
  ) async {
    emit(ItemUpdateStateLoading());
    try {
      RequestItem updateItem = RequestItem(itemName: event.itemName);
      UseCaseGeneric useCaseGeneric = await repositoryInventory.itemUpdate(
        updateItem: updateItem,
        itemId: event.itemId,
      );
      emit(
        ItemUpdateStateResult(
          message: useCaseGeneric.message!,
          isNavigate: useCaseGeneric.isSuccess,
        ),
      );
    } catch (e) {
      emit(
        ItemUpdateStateResult(
          message: ClientConstant.serverError,
          isNavigate: false,
        ),
      );
    }
  }
}
