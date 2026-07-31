/* 
Created by Neloy on 25 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import '../model/model_shop_details.dart';
import '../model/model_shop_list.dart';
import '../network/api_call/shop/api_get_shop_list.dart';
import '../network/api_call/shop/user/api_get_shop_details_user.dart';
import '../use_case/use_case_generic.dart';

abstract class IRepositoryShop {
  Future<UseCaseGeneric<List<ModelShopList>>> getShopList();

  Future<UseCaseGeneric<ModelShopDetails>> getShopDetailsUser({
    required String shopId,
  });
}

class RepositoryShop implements IRepositoryShop {
  final IApiGetShopList apiGetShopList;
  final IApiGetShopDetailsUser apiGetShopDetailsUser;

  const RepositoryShop({
    required this.apiGetShopList,
    required this.apiGetShopDetailsUser,
  });

  @override
  Future<UseCaseGeneric<List<ModelShopList>>> getShopList() async {
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

  @override
  Future<UseCaseGeneric<ModelShopDetails>> getShopDetailsUser({
    required String shopId,
  }) async {
    try {
      var (modelShopDetails, modelError) = await apiGetShopDetailsUser
          .getDetails(shopId: shopId);
      if (modelError == null) {
        return UseCaseGeneric(isSuccess: true, data: modelShopDetails);
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }
}
