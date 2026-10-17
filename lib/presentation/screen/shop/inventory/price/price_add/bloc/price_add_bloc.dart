/* 
Created by Neloy on 16 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/request/request_price_add.dart';

import '../../../../../../../data/client/client_constant.dart';
import '../../../../../../../data/model/model_item_list.dart';
import '../../../../../../../data/model/model_service_list.dart';
import '../../../../../../../data/repository/repository_shop_inventory.dart';
import '../../../../../../../data/use_case/use_case_generic.dart';

part 'price_add_event.dart';

part 'price_add_state.dart';

class PriceAddBloc extends Bloc<PriceAddEvent, PriceAddState> {
  final IRepositoryShopInventory repositoryInventory;

  PriceAddBloc({required this.repositoryInventory})
    : super(PriceAddStateInitial()) {
    on<PriceAddEventDropdownDataFetch>(_onPriceAddEventDropdownDataFetch);
    on<PriceAddEventSubmit>(_onPriceAddEventSubmit);
  }

  Future<void> _onPriceAddEventDropdownDataFetch(
    PriceAddEventDropdownDataFetch event,
    Emitter<PriceAddState> emit,
  ) async {
    emit(PriceAddStateLoading());
    try {
      final results = await Future.wait([
        repositoryInventory.getServiceList(),
        repositoryInventory.getItemList(),
      ]);

      final serviceList = results[0] as UseCaseGeneric<List<ModelServiceList>>;
      final itemList = results[1] as UseCaseGeneric<List<ModelItemList>>;

      if (serviceList.isSuccess && itemList.isSuccess) {
        emit(
          PriceAddStateDropdownDataLoaded(
            itemList: itemList.data!,
            serviceList: serviceList.data!,
            isNavigate: false,
            message: "",
            needLoader: false,
          ),
        );
      } else {
        emit(
          PriceAddStateDropdownDataLoaded(
            itemList: [],
            serviceList: [],
            message: !serviceList.isSuccess
                ? serviceList.message!
                : !itemList.isSuccess
                ? itemList.message!
                : ClientConstant.unableToSetDropdown,
            isNavigate: false,
            needLoader: false,
          ),
        );
      }
    } catch (e) {
      emit(
        PriceAddStateDropdownDataLoaded(
          itemList: [],
          serviceList: [],
          message: ClientConstant.serverError,
          isNavigate: false,
          needLoader: false,
        ),
      );
    }
  }

  Future<void> _onPriceAddEventSubmit(
    PriceAddEventSubmit event,
    Emitter<PriceAddState> emit,
  ) async {
    if (state is! PriceAddStateDropdownDataLoaded) return;
    final currentState = state as PriceAddStateDropdownDataLoaded;
    emit(currentState.copyWith(needLoader: true, isNavigate: false, message: ""));
    try {
      RequestPriceAdd priceAdd = RequestPriceAdd(
        price: event.price,
        discountPrice: event.discountPrice,
        ironPressPrice: event.ironPressPrice,
        serviceId: event.serviceId,
        itemId: event.itemId,
      );

      UseCaseGeneric useCaseGeneric = await repositoryInventory.priceAdd(
        priceAdd: priceAdd,
      );

      emit(
        currentState.copyWith(
          message: useCaseGeneric.message!,
          isNavigate: useCaseGeneric.isSuccess,
          needLoader: false,
        ),
      );
    } catch (e) {
      emit(
        currentState.copyWith(
          message: ClientConstant.serverError,
          isNavigate: false,
          needLoader: false,
        ),
      );
    }
  }
}
