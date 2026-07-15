/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:wash_your_cloth_mobile_app/data/network/api_call/order/i_api_get_order_list.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/order/use_case_order_list.dart';

import '../client/client_constant.dart';

abstract class IRepositoryOrder {
  Future<UseCaseOrderList> getOrderListUser();
}

class RepositoryOrder implements IRepositoryOrder {
  final IApiGetOrderList apiGetOrderList;

  const RepositoryOrder({required this.apiGetOrderList});

  @override
  Future<UseCaseOrderList> getOrderListUser() async {
    try {
      var (modelOrderList, modelError) = await apiGetOrderList.getOrderList();
      if (modelError == null) {
        return UseCaseOrderList(isListFetch: true, orderList: modelOrderList);
      } else {
        return UseCaseOrderList(
          isListFetch: false,
          message: modelError.error?.isNotEmpty == true
              ? modelError.error!.first
              : ClientConstant.serverError,
        );
      }
    } catch (e) {
      return UseCaseOrderList(
        message: ClientConstant.serverError,
        isListFetch: false,
      );
    }
  }
}
