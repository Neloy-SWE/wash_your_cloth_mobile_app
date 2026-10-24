/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import '../../utilities/app_constant.dart';
import '../model/model_order_details_shop.dart';
import '../model/model_order_details_user.dart';
import '../model/model_order_list.dart';
import '../model/model_paged_list.dart';
import '../network/api_call/order/shop/api_get_order_details_shop.dart';
import '../network/api_call/order/user/api_get_order_details_user.dart';
import '../network/api_call/order/api_get_order_list.dart';
import '../network/api_call/order/api_update_order_status.dart';
import '../network/api_call/order/user/api_place_order.dart';
import '../use_case/order/use_case_order_place.dart';
import '../use_case/use_case_generic.dart';

abstract class IRepositoryOrder {
  Future<UseCaseGeneric<ModelPagedList<ModelOrderList>>> getOrderList({
    required int currentPage,
    required int pageSize,
    String? search,
  });

  Future<UseCaseGeneric<ModelOrderDetailsUser>> getOrderDetailsUser({
    required String orderId,
  });

  Future<UseCaseGeneric<ModelOrderDetailsShop>> getOrderDetailsShop({
    required String orderId,
  });

  Future<UseCaseGeneric> placeOrder({required OrderPlaceData orderPlaceData});

  Future<UseCaseGeneric> updateStatus({
    required String orderId,
    required OrderStatusAction action,
  });
}

class RepositoryOrder implements IRepositoryOrder {
  final IApiGetOrderList apiGetOrderList;
  final IApiGetOrderDetailsUser apiGetOrderDetailsUser;
  final IApiGetOrderDetailsShop apiGetOrderDetailsShop;
  final IApiPlaceOrder apiPlaceOrder;
  final IApiOrderStatusUpdate apiUpdateOrderStatus;

  const RepositoryOrder({
    required this.apiGetOrderList,
    required this.apiGetOrderDetailsUser,
    required this.apiPlaceOrder,
    required this.apiGetOrderDetailsShop,
    required this.apiUpdateOrderStatus,
  });

  @override
  Future<UseCaseGeneric<ModelPagedList<ModelOrderList>>> getOrderList({
    required int currentPage,
    required int pageSize,
    String? search,
  }) async {
    try {
      var (modelOrderList, modelError) = await apiGetOrderList.getOrderList(
        currentPage: currentPage,
        pageSize: pageSize,
        search: search,
      );
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

  @override
  Future<UseCaseGeneric> placeOrder({
    required OrderPlaceData orderPlaceData,
  }) async {
    try {
      var (modelOrderPlace, modelError) = await apiPlaceOrder.placeOrder(
        data: orderPlaceData.toJson(),
      );
      if (modelError == null) {
        return UseCaseGeneric(
          isSuccess: true,
          message: modelOrderPlace?.message,
        );
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric<ModelOrderDetailsShop>> getOrderDetailsShop({
    required String orderId,
  }) async {
    try {
      var (modelOrderDetails, modelError) = await apiGetOrderDetailsShop
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

  @override
  Future<UseCaseGeneric> updateStatus({
    required String orderId,
    required OrderStatusAction action,
  }) async {
    try {
      final (modelOrderStatusUpdate, modelError) = await apiUpdateOrderStatus
          .updateStatus(orderId: orderId, action: action);
      if (modelError == null && modelOrderStatusUpdate != null) {
        return UseCaseGeneric(
          isSuccess: true,
          message: modelOrderStatusUpdate.message,
        );
      }
      return UseCaseGeneric.fromModelError(modelError!);
    } catch (error) {
      return UseCaseGeneric.serverError();
    }
  }
}
