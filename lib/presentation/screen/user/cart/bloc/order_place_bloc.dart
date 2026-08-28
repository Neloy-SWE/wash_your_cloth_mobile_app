/* 
Created by Neloy on 25 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/client/client_constant.dart';
import '../../../../../data/repository/repository_order.dart';
import '../../../../../data/use_case/order/use_case_order_place.dart';
import '../../../../../data/use_case/use_case_generic.dart';

part 'order_place_event.dart';

part 'order_place_state.dart';

class OrderPlaceBloc extends Bloc<OrderPlaceEvent, OrderPlaceState> {
  final IRepositoryOrder repositoryOrder;

  OrderPlaceBloc({required this.repositoryOrder})
    : super(OrderPlaceStateInitial()) {
    on<OrderPlaceEventSubmit>(_onOrderPlaceEventSubmit);
  }

  Future<void> _onOrderPlaceEventSubmit(
    OrderPlaceEventSubmit event,
    Emitter<OrderPlaceState> emit,
  ) async {
    emit(OrderPlaceStateLoading());
    try {
      UseCaseGeneric useCaseGeneric = await repositoryOrder.placeOrder(
        orderPlaceData: event.orderPlaceData,
      );
      emit(
        OrderPlaceStateResult(
          message: useCaseGeneric.message!,
          isNavigate: useCaseGeneric.isSuccess,
        ),
      );
    } catch (e) {
      emit(
        OrderPlaceStateResult(
          message: ClientConstant.serverError,
          isNavigate: false,
        ),
      );
    }
  }
}
