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

part 'item_add_event.dart';

part 'item_add_state.dart';

class ItemAddBloc extends Bloc<ItemAddEvent, ItemAddState> {
  final IRepositoryShopInventory repositoryInventory;

  ItemAddBloc({required this.repositoryInventory})
    : super(ItemAddStateInitial()) {
    on<ItemAddEventSubmit>(_onItemAddEventSubmit);
  }

  Future<void> _onItemAddEventSubmit(
    ItemAddEventSubmit event,
    Emitter<ItemAddState> emit,
  ) async {
    emit(ItemAddStateLoading());
    try {
      RequestItem itemAdd = RequestItem(itemName: event.itemName);
      UseCaseGeneric useCaseGeneric = await repositoryInventory.itemAdd(
        itemAdd: itemAdd,
      );
      emit(
        ItemAddStateResult(
          message: useCaseGeneric.message!,
          isNavigate: useCaseGeneric.isSuccess,
        ),
      );
    } catch (e) {
      emit(
        ItemAddStateResult(
          message: ClientConstant.serverError,
          isNavigate: false,
        ),
      );
    }
  }
}
