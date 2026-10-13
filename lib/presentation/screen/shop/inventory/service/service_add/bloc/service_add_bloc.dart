/* 
Created by Neloy on 13 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../data/client/client_constant.dart';
import '../../../../../../../data/repository/repository_shop_inventory.dart';
import '../../../../../../../data/request/request_service.dart';
import '../../../../../../../data/use_case/use_case_generic.dart';

part 'service_add_event.dart';

part 'service_add_state.dart';

class ServiceAddBloc extends Bloc<ServiceAddEvent, ServiceAddState> {
  final IRepositoryShopInventory repositoryInventory;

  ServiceAddBloc({required this.repositoryInventory})
    : super(ServiceAddStateInitial()) {
    on<ServiceAddEventSubmit>(_onServiceAddEventSubmit);
  }

  Future<void> _onServiceAddEventSubmit(
    ServiceAddEventSubmit event,
    Emitter<ServiceAddState> emit,
  ) async {
    emit(ServiceAddStateLoading());
    try {
      RequestService serviceAdd = RequestService(
        serviceName: event.serviceName,
        description: event.description,
      );
      UseCaseGeneric useCaseGeneric = await repositoryInventory.serviceAdd(
        serviceAdd: serviceAdd,
      );
      emit(
        ServiceAddStateResult(
          message: useCaseGeneric.message!,
          isNavigate: useCaseGeneric.isSuccess,
        ),
      );
    } catch (e) {
      emit(
        ServiceAddStateResult(
          message: ClientConstant.serverError,
          isNavigate: false,
        ),
      );
    }
  }
}
