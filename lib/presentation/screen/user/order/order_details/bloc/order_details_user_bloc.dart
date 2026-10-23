/* 
Created by Neloy on 18 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/client/client_constant.dart';
import '../../../../../../data/model/model_order_details_user.dart';
import '../../../../../../data/repository/repository_order.dart';
import '../../../../../../data/use_case/use_case_generic.dart';
import '../../../../../../utilities/app_constant.dart';

part 'order_details_user_event.dart';

part 'order_details_user_state.dart';

class OrderDetailsUserBloc
    extends Bloc<OrderDetailsUserEvent, OrderDetailsUserState> {
  final IRepositoryOrder repositoryOrder;

  OrderDetailsUserBloc({required this.repositoryOrder})
    : super(OrderDetailsUserStateInitial()) {
    on<OrderDetailsUserEventFetch>(_onOrderDetailsUserEventFetch);
    on<OrderDetailsUserEventUpdateStatus>(_onUpdateStatus);
  }

  Future<void> _onOrderDetailsUserEventFetch(
    OrderDetailsUserEventFetch event,
    Emitter<OrderDetailsUserState> emit,
  ) async {
    emit(OrderDetailsUserStateLoading());
    try {
      UseCaseGeneric<ModelOrderDetailsUser> useCaseOrderDetails =
          await repositoryOrder.getOrderDetailsUser(orderId: event.orderId);
      if (useCaseOrderDetails.isSuccess) {
        emit(
          OrderDetailsUserStateFetch(
            orderDetailsUser: useCaseOrderDetails.data!,
          ),
        );
      } else {
        emit(
          OrderDetailsUserStateResult(message: useCaseOrderDetails.message!),
        );
      }
    } catch (e) {
      emit(OrderDetailsUserStateResult(message: ClientConstant.serverError));
    }
  }

  Future<void> _onUpdateStatus(
    OrderDetailsUserEventUpdateStatus event,
    Emitter<OrderDetailsUserState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OrderDetailsUserStateFetch ||
        currentState.isUpdating) {
      return;
    }

    emit(currentState.copyWith(isUpdating: true, actionError: ""));
    final result = await repositoryOrder.updateStatus(
      orderId: event.orderId,
      action: event.action,
    );
    if (!result.isSuccess) {
      emit(
        currentState.copyWith(
          isUpdating: false,
          actionError: result.message ?? ClientConstant.serverError,
        ),
      );
      return;
    }

    emit(
      currentState.copyWith(
        orderDetailsUser: currentState.orderDetailsUser.copyWith(
          status: event.action.name,
        ),
        actionMessage: result.message,
      ),
    );
  }
}
