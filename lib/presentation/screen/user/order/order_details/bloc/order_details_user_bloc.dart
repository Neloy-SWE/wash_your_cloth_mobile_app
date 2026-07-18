/* 
Created by Neloy on 18 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_order_details_user.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/order/use_case_order.dart';

import '../../../../../../data/client/client_constant.dart';
import '../../../../../../data/repository/repository_order.dart';

part 'order_details_user_event.dart';

part 'order_details_user_state.dart';

class OrderDetailsUserBloc
    extends Bloc<OrderDetailsUserEvent, OrderDetailsUserState> {
  final IRepositoryOrder repositoryOrder;

  OrderDetailsUserBloc({required this.repositoryOrder})
    : super(OrderDetailsUserStateInitial()) {
    on<OrderDetailsUserEventFetch>(_onOrderDetailsUserEventFetch);
  }

  Future<void> _onOrderDetailsUserEventFetch(
    OrderDetailsUserEventFetch event,
    Emitter<OrderDetailsUserState> emit,
  ) async {
    emit(OrderDetailsUserStateLoading());
    try {
      UseCaseOrder<ModelOrderDetailsUser> useCaseOrderDetails =
          await repositoryOrder.getOrderDetails(orderId: event.orderId);
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
}
