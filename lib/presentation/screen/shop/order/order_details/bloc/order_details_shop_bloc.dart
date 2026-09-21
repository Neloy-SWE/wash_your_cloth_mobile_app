/* 
Created by Neloy on 18 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_order_details_user.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/use_case_generic.dart';

import '../../../../../../data/client/client_constant.dart';
import '../../../../../../data/model/model_order_details_shop.dart';
import '../../../../../../data/repository/repository_order.dart';

part 'order_details_shop_event.dart';

part 'order_details_shop_state.dart';

class OrderDetailsShopBloc
    extends Bloc<OrderDetailsShopEvent, OrderDetailsShopState> {
  final IRepositoryOrder repositoryOrder;

  OrderDetailsShopBloc({required this.repositoryOrder})
    : super(OrderDetailsShopStateInitial()) {
    on<OrderDetailsShopEventFetch>(_onOrderDetailsShopEventFetch);
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
}
