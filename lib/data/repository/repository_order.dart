/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:wash_your_cloth_mobile_app/data/model/model_order_details_user.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_order_list.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/order/api_get_order_details_user.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/order/i_api_get_order_list.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/order/use_case_order.dart';

import '../client/client_constant.dart';

abstract class IRepositoryOrder {
  Future<UseCaseOrder<List<ModelOrderList>>> getOrderListUser();

  Future<UseCaseOrder<ModelOrderDetailsUser>> getOrderDetails({
    required String orderId,
  });
}

class RepositoryOrder implements IRepositoryOrder {
  final IApiGetOrderList apiGetOrderList;
  final IApiGetOrderDetailsUser apiGetOrderDetailsUser;

  const RepositoryOrder({
    required this.apiGetOrderList,
    required this.apiGetOrderDetailsUser,
  });

  @override
  Future<UseCaseOrder<List<ModelOrderList>>> getOrderListUser() async {
    try {
      var (modelOrderList, modelError) = await apiGetOrderList.getOrderList();
      if (modelError == null) {
        return UseCaseOrder(isSuccess: true, data: modelOrderList);
      } else {
        // return UseCaseOrder(
        //   isSuccess: false,
        //   message: modelError.error?.isNotEmpty == true
        //       ? modelError.error!.first
        //       : ClientConstant.serverError,
        // );
        return UseCaseOrder.fromModelError(modelError);
      }
    } catch (e) {
      // return UseCaseOrder(message: ClientConstant.serverError, isSuccess: false);
      return UseCaseOrder.serverError();
    }
  }

  @override
  Future<UseCaseOrder<ModelOrderDetailsUser>> getOrderDetails({
    required String orderId,
  }) async {
    try {
      var (modelOrderDetails, modelError) = await apiGetOrderDetailsUser
          .getDetails(orderId: orderId);
      if (modelError == null) {
        return UseCaseOrder(isSuccess: true, data: modelOrderDetails);
      } else {
        return UseCaseOrder.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseOrder.serverError();
    }
  }
}
