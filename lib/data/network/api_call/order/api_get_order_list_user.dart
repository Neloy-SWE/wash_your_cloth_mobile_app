/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'i_api_get_order_list.dart';

class ApiGetOrderListUser implements IApiGetOrderList {
  final Client client;

  const ApiGetOrderListUser({required this.client});

  @override
  Future<(List<ModelOrderList>?, ModelError?)> getOrderList() async {
    try {
      Response response = await client.request.get(ApiPath.orderListUser);

      if (response.statusCode == ClientConstant.statusCode200OK) {
        var modelOrderList = List<ModelOrderList>.from(
          response.data.map((x) => ModelOrderList.fromJson(x)),
        );

        return (modelOrderList, null);
      } else {
        ModelError modelError = ModelError.fromJson(response.data);
        return (null, modelError);
      }
    } catch (e) {
      ModelError modelError = ModelError(error: []);
      return (null, modelError);
    }
  }
}
