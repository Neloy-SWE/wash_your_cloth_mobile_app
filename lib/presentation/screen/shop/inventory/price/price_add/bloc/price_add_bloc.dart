/* 
Created by Neloy on 16 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/request/request_price_add.dart';

import '../../../../../../../data/client/client_constant.dart';
import '../../../../../../../data/model/model_item_list.dart';
import '../../../../../../../data/model/model_paged_list.dart';
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
        _fetchAllPages<ModelServiceList>(
          (currentPage) => repositoryInventory.getServiceList(
            currentPage: currentPage,
            pageSize: ClientConstant.maxPageSize,
          ),
        ),
        _fetchAllPages<ModelItemList>(
          (currentPage) => repositoryInventory.getItemList(
            currentPage: currentPage,
            pageSize: ClientConstant.maxPageSize,
          ),
        ),
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

  Future<UseCaseGeneric<List<T>>> _fetchAllPages<T>(
    Future<UseCaseGeneric<ModelPagedList<T>>> Function(int currentPage)
    fetchPage,
  ) async {
    final items = <T>[];
    var currentPage = 0;
    var totalItem = 0;

    do {
      final result = await fetchPage(currentPage);
      if (!result.isSuccess || result.data == null) {
        return UseCaseGeneric(
          isSuccess: false,
          message: result.message ?? ClientConstant.serverError,
        );
      }

      final page = result.data!;
      if (page.items.isEmpty && items.length < page.totalItem) {
        return UseCaseGeneric.serverError();
      }
      items.addAll(page.items);
      totalItem = page.totalItem;
      currentPage = page.currentPage + 1;
    } while (items.length < totalItem);

    return UseCaseGeneric(isSuccess: true, data: items);
  }

  Future<void> _onPriceAddEventSubmit(
    PriceAddEventSubmit event,
    Emitter<PriceAddState> emit,
  ) async {
    if (state is! PriceAddStateDropdownDataLoaded) return;
    final currentState = state as PriceAddStateDropdownDataLoaded;
    emit(
      currentState.copyWith(needLoader: true, isNavigate: false, message: ""),
    );
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
