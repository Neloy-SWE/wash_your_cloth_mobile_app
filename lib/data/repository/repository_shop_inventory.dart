/* 
Created by Neloy on 02 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:wash_your_cloth_mobile_app/data/network/api_call/resource/shop/api_get_price_list_shop.dart';

import '../model/model_price_list_shop.dart';
import '../use_case/use_case_generic.dart';

abstract class IRepositoryShopInventory {
  Future<UseCaseGeneric<List<ModelPriceListShop>>> getPriceListUser();
}

class RepositoryShopInventory implements IRepositoryShopInventory {
  final IApiGetPriceListShop apiGetPriceListShop;

  RepositoryShopInventory({required this.apiGetPriceListShop});

  @override
  Future<UseCaseGeneric<List<ModelPriceListShop>>> getPriceListUser() async {
    try {
      var (modelPriceListShop, modelError) = await apiGetPriceListShop
          .getPriceList();
      if (modelError == null) {
        return UseCaseGeneric(isSuccess: true, data: modelPriceListShop);
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }
}
