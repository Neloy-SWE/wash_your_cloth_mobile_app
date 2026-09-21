/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/repository/repository_order.dart';

import '../../../../../../data/client/client_constant.dart';
import '../../../../../../data/model/model_order_list.dart';
import '../../../../../../data/use_case/use_case_generic.dart';

part 'order_list_shop_event.dart';

part 'order_list_shop_state.dart';

class OrderListShopBloc extends Bloc<OrderListShopEvent, OrderListShopState> {
  final IRepositoryOrder repositoryOrder;

  OrderListShopBloc({required this.repositoryOrder})
    : super(OrderListShopStateInitial()) {
    on<OrderListShopEventFetch>(_onOrderListShopEventFetch);
  }

  Future<void> _onOrderListShopEventFetch(
    OrderListShopEventFetch event,
    Emitter<OrderListShopState> emit,
  ) async {
    emit(OrderListShopStateLoading());
    try {
      UseCaseGeneric<List<ModelOrderList>> useCaseOrderList =
          await repositoryOrder.getOrderList();
      if (useCaseOrderList.isSuccess) {
        emit(OrderListShopStateFetch(orderList: useCaseOrderList.data!));
      } else {
        emit(OrderListShopStateResult(message: useCaseOrderList.message!));
      }
    } catch (e) {
      emit(OrderListShopStateResult(message: ClientConstant.serverError));
    }
  }
}
