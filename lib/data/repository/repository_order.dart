/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:wash_your_cloth_mobile_app/data/model/model_order_details_user.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_order_list.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/order/user/api_get_order_details_user.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/order/i_api_get_order_list.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/use_case_generic.dart';

abstract class IRepositoryOrder {
  Future<UseCaseGeneric<List<ModelOrderList>>> getOrderListUser();

  Future<UseCaseGeneric<ModelOrderDetailsUser>> getOrderDetails({
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
  Future<UseCaseGeneric<List<ModelOrderList>>> getOrderListUser() async {
    try {
      var (modelOrderList, modelError) = await apiGetOrderList.getOrderList();
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
  Future<UseCaseGeneric<ModelOrderDetailsUser>> getOrderDetails({
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
