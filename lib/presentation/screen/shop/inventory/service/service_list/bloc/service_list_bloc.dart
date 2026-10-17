/* 
Created by Neloy on 10a October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../data/client/client_constant.dart';
import '../../../../../../../data/model/model_service_list.dart';
import '../../../../../../../data/repository/repository_shop_inventory.dart';
import '../../../../../../../data/use_case/use_case_generic.dart';
import '../../../../../../../utilities/app_validator.dart';

part 'service_list_event.dart';

part 'service_list_state.dart';

class ServiceListBloc extends Bloc<ServiceListEvent, ServiceListState> {
  final IRepositoryShopInventory repositoryShopInventory;

  ServiceListBloc({required this.repositoryShopInventory})
    : super(ServiceListStateInitial()) {
    on<ServiceListEventFetch>(_onServiceListEventFetch);
    on<ServiceListEventActivation>(_onServiceListEventActivation);
    on<ServiceListEventUpdate>(_onServiceListEventUpdate);
  }

  Future<void> _onServiceListEventFetch(
    ServiceListEventFetch event,
    Emitter<ServiceListState> emit,
  ) async {
    emit(ServiceListStateLoading());
    try {
      UseCaseGeneric<List<ModelServiceList>> useCaseServiceList =
          await repositoryShopInventory.getServiceList();
      if (useCaseServiceList.isSuccess) {
        emit(ServiceListStateFetch(serviceList: useCaseServiceList.data!));
      } else {
        emit(ServiceListStateError(message: useCaseServiceList.message!));
      }
    } catch (e) {
      emit(const ServiceListStateError(message: ClientConstant.serverError));
    }
  }

  Future<void> _onServiceListEventActivation(
    ServiceListEventActivation event,
    Emitter<ServiceListState> emit,
  ) async {
    if (state is! ServiceListStateFetch) return;
    final currentState = state as ServiceListStateFetch;
    final currentList = currentState.serviceList;

    emit(currentState.copyWith(isActivating: true));

    try {
      UseCaseGeneric activation = await repositoryShopInventory
          .serviceActivation(serviceId: event.serviceId);

      if (activation.isSuccess) {
        final index = currentList.indexWhere(
          (item) => item.id == event.serviceId,
        );
        if (index != -1) {
          final updatedList = List<ModelServiceList>.from(currentList);
          updatedList[index] = updatedList[index].copyWith(
            isActive: !updatedList[index].isActive,
          );

          emit(
            ServiceListStateActionResult(
              message: activation.message!,
              isSuccess: activation.isSuccess,
            ),
          );

          emit(
            ServiceListStateFetch(
              serviceList: updatedList,
              isActivating: false,
            ),
          );
        } else {
          emit(
            ServiceListStateActionResult(
              message: AppValidator.validatorInvalidService,
              isSuccess: false,
            ),
          );
          emit(currentState.copyWith(isActivating: false));
        }
      } else {
        emit(
          ServiceListStateActionResult(
            message: activation.message!,
            isSuccess: activation.isSuccess,
          ),
        );
        emit(currentState.copyWith(isActivating: false));
      }
    } catch (e) {
      emit(
        const ServiceListStateActionResult(
          message: ClientConstant.serverError,
          isSuccess: false,
        ),
      );
      emit(currentState.copyWith(isActivating: false));
    }
  }

  Future<void> _onServiceListEventUpdate(
    ServiceListEventUpdate event,
    Emitter<ServiceListState> emit,
  ) async {
    try {
      if (state is! ServiceListStateFetch) return;
      final currentState = state as ServiceListStateFetch;
      final currentList = currentState.serviceList;

      final index = currentList.indexWhere(
        (item) => item.id == event.serviceId,
      );
      if (index != -1) {
        final updatedList = List<ModelServiceList>.from(currentList);
        updatedList[index] = updatedList[index].copyWith(
          serviceName: event.serviceName,
          description: event.description,
        );

        emit(ServiceListStateFetch(serviceList: updatedList, isUpdating: true));
      } else {
        emit(
          ServiceListStateActionResult(
            message: AppValidator.validatorInvalidService,
            isSuccess: false,
          ),
        );
      }
    } catch (e) {
      emit(
        const ServiceListStateActionResult(
          message: ClientConstant.serverError,
          isSuccess: false,
        ),
      );
    }
  }
}
