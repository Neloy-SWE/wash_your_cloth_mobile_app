/* 
Created by Neloy on 25 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import '../model/model_shop_list.dart';
import '../network/api_call/shop/api_get_shop_list.dart';
import '../use_case/use_case_generic.dart';

abstract class IRepositoryShop {
  Future<UseCaseGeneric<List<ModelSopList>>> getOrderListUser();
}

class RepositoryShop implements IRepositoryShop {
  final IApiGetShopList apiGetShopList;

  const RepositoryShop({required this.apiGetShopList});

  @override
  Future<UseCaseGeneric<List<ModelSopList>>> getOrderListUser() async {
    try {
      var (modelSopList, modelError) = await apiGetShopList.getShopList();
      if (modelError == null) {
        return UseCaseGeneric(isSuccess: true, data: modelSopList);
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }
}
