/* 
Created by Neloy on 18 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/client/client_constant.dart';
import '../../../../../../data/model/model_order_details_shop.dart';
import '../../../../../../data/repository/repository_order.dart';
import '../../../../../../data/use_case/use_case_generic.dart';
import '../../../../../../utilities/app_constant.dart';

part 'order_details_shop_event.dart';

part 'order_details_shop_state.dart';

class OrderDetailsShopBloc
    extends Bloc<OrderDetailsShopEvent, OrderDetailsShopState> {
  final IRepositoryOrder repositoryOrder;

  OrderDetailsShopBloc({required this.repositoryOrder})
    : super(OrderDetailsShopStateInitial()) {
    on<OrderDetailsShopEventFetch>(_onOrderDetailsShopEventFetch);
    on<OrderDetailsShopEventUpdateStatus>(_onUpdateStatus);
  }

  Future<void> _onOrderDetailsShopEventFetch(
    OrderDetailsShopEventFetch event,
    Emitter<OrderDetailsShopState> emit,
  ) async {
    emit(OrderDetailsShopStateLoading());
    try {
      UseCaseGeneric<ModelOrderDetailsShop> useCaseOrderDetails =
          await repositoryOrder.getOrderDetailsShop(orderId: event.orderId);
      if (useCaseOrderDetails.isSuccess) {
        emit(
          OrderDetailsShopStateFetch(
            orderDetailsShop: useCaseOrderDetails.data!,
          ),
        );
      } else {
        emit(
          OrderDetailsShopStateResult(message: useCaseOrderDetails.message!),
        );
      }
    } catch (e) {
      emit(OrderDetailsShopStateResult(message: ClientConstant.serverError));
    }
  }

  Future<void> _onUpdateStatus(
    OrderDetailsShopEventUpdateStatus event,
    Emitter<OrderDetailsShopState> emit,
  ) async {
    final currentState = state;
    if (currentState is! OrderDetailsShopStateFetch ||
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
        currentState.copyWith(isUpdating: false, actionError: result.message),
      );
      return;
    }

    final status = switch (event.action) {
      OrderStatusAction.accepted => OrderStatusAction.accepted.name,
      OrderStatusAction.rejected => OrderStatusAction.rejected.name,
      OrderStatusAction.ready => OrderStatusAction.ready.name,
      OrderStatusAction.handoverRequest =>
        OrderStatusAction.handoverRequest.name,
      OrderStatusAction.received => currentState.orderDetailsShop.status,
    };
    emit(
      currentState.copyWith(
        orderDetailsShop: currentState.orderDetailsShop.copyWith(
          status: status,
        ),
        actionMessage: result.message,
      ),
    );
  }
}
