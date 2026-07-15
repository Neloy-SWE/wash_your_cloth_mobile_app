/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/repository/repository_order.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/order/use_case_order_list.dart';

import '../../../../../data/client/client_constant.dart';
import '../../../../../data/model/model_order_list.dart';

part 'order_list_user_event.dart';

part 'order_list_user_state.dart';

class OrderListUserBloc extends Bloc<OrderListUserEvent, OrderListUserState> {
  final IRepositoryOrder repositoryOrder;

  OrderListUserBloc({required this.repositoryOrder})
    : super(OrderListUserStateInitial()) {
    on<OrderListUserEventFetch>(_onOrderListUserEventFetch);
  }

  Future<void> _onOrderListUserEventFetch(
    OrderListUserEventFetch event,
    Emitter<OrderListUserState> emit,
  ) async {
    emit(OrderListUserStateLoading());
    try {
      UseCaseOrderList useCaseOrderList = await repositoryOrder
          .getOrderListUser();
      if (useCaseOrderList.isListFetch) {
        emit(OrderListUserStateFetch(orderList: useCaseOrderList.orderList!));
      } else {
        emit(OrderListUserStateResult(message: useCaseOrderList.message!));
      }
    } catch (e) {
      emit(OrderListUserStateResult(message: ClientConstant.serverError));
    }
  }
}
