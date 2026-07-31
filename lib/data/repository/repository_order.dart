/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import '../model/model_order_details_user.dart';
import '../model/model_order_list.dart';
import '../network/api_call/order/user/api_get_order_details_user.dart';
import '../network/api_call/order/user/api_get_order_list_user.dart';
import '../use_case/use_case_generic.dart';

abstract class IRepositoryOrder {
  Future<UseCaseGeneric<List<ModelOrderList>>> getOrderListUser();

  Future<UseCaseGeneric<ModelOrderDetailsUser>> getOrderDetailsUser({
    required String orderId,
  });
}

class RepositoryOrder implements IRepositoryOrder {
  final IApiGetOrderListUser apiGetOrderListUser;
  final IApiGetOrderDetailsUser apiGetOrderDetailsUser;

  const RepositoryOrder({
    required this.apiGetOrderListUser,
    required this.apiGetOrderDetailsUser,
  });

  @override
  Future<UseCaseGeneric<List<ModelOrderList>>> getOrderListUser() async {
    try {
      var (modelOrderList, modelError) = await apiGetOrderListUser
          .getOrderList();
      if (modelError == null) {
        return UseCaseGeneric(isSuccess: true, data: modelOrderList);
      } else {
        // return UseCaseOrder(
        //   isSuccess: false,
        //   message: modelError.error?.isNotEmpty == true
        //       ? modelError.error!.first
        //       : ClientConstant.serverError,
        // );
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      // return UseCaseOrder(message: ClientConstant.serverError, isSuccess: false);
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric<ModelOrderDetailsUser>> getOrderDetailsUser({
    required String orderId,
  }) async {
    try {
      var (modelOrderDetails, modelError) = await apiGetOrderDetailsUser
          .getDetails(orderId: orderId);
      if (modelError == null) {
        return UseCaseGeneric(isSuccess: true, data: modelOrderDetails);
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }
}
