/* 
Created by Neloy on 11 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../data/client/client_constant.dart';
import '../../../../../../../data/repository/repository_shop_inventory.dart';
import '../../../../../../../data/request/request_update_service.dart';
import '../../../../../../../data/use_case/use_case_generic.dart';

part 'service_update_event.dart';

part 'service_update_state.dart';

class ServiceUpdateBloc extends Bloc<ServiceUpdateEvent, ServiceUpdateState> {
  final IRepositoryShopInventory repositoryInventory;

  ServiceUpdateBloc({required this.repositoryInventory})
    : super(ServiceUpdateStateInitial()) {
    on<ServiceUpdateEventSubmit>(_onServiceUpdateEventSubmit);
  }

  Future<void> _onServiceUpdateEventSubmit(
    ServiceUpdateEventSubmit event,
    Emitter<ServiceUpdateState> emit,
  ) async {
    emit(ServiceUpdateStateLoading());
    try {
      RequestUpdateService updateService = RequestUpdateService(
        serviceName: event.serviceName,
        description: event.description,
      );
      UseCaseGeneric useCaseGeneric = await repositoryInventory.serviceUpdate(
        updateService: updateService,
        serviceId: event.serviceId,
      );
      emit(
        ServiceUpdateStateResult(
          message: useCaseGeneric.message!,
          isNavigate: useCaseGeneric.isSuccess,
        ),
      );
    } catch (e) {
      emit(
        ServiceUpdateStateResult(
          message: ClientConstant.serverError,
          isNavigate: false,
        ),
      );
    }
  }
}
