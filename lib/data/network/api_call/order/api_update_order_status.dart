/*
Created by Neloy on 21 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import '../../../../utilities/app_constant.dart';
import '../../../client/client.dart';
import '../../../client/client_constant.dart';
import '../../../model/model_error.dart';
import '../../../model/model_order_status_update.dart';
import '../../api_path.dart';

abstract class IApiOrderStatusUpdate {
  Future<(ModelOrderStatusUpdate?, ModelError?)> updateStatus({
    required String orderId,
    required OrderStatusAction action,
  });
}

class ApiOrderStatusUpdate implements IApiOrderStatusUpdate {
  final Client client;

  const ApiOrderStatusUpdate({required this.client});

  @override
  Future<(ModelOrderStatusUpdate?, ModelError?)> updateStatus({
    required String orderId,
    required OrderStatusAction action,
  }) async {
    final endpoint = switch (action) {
      OrderStatusAction.accepted => ApiPath.orderAccept,
      OrderStatusAction.rejected => ApiPath.orderReject,
      OrderStatusAction.ready => ApiPath.orderReady,
      OrderStatusAction.handoverRequest => ApiPath.orderHandoverRequest,
      OrderStatusAction.received => ApiPath.orderConfirmReceived,
    };

    try {
      final response = await client.request.patch("$endpoint$orderId");
      if (response.statusCode == ClientConstant.statusCode200OK) {
        return (ModelOrderStatusUpdate.fromJson(response.data), null);
      }
      return (null, ModelError.fromJson(response.data));
    } catch (error) {
      return (null, ModelError(error: [ClientConstant.serverError]));
    }
  }
}
