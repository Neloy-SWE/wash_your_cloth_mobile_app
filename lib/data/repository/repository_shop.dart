/* 
Created by Neloy on 25 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:wash_your_cloth_mobile_app/data/model/model_price_list_user.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/resource/user/api_get_price_list_user.dart';

import '../model/model_shop_details.dart';
import '../model/model_shop_list.dart';
import '../model/model_paged_list.dart';
import '../network/api_call/shop/api_get_shop_list.dart';
import '../network/api_call/shop/user/api_get_shop_details_user.dart';
import '../use_case/use_case_generic.dart';

abstract class IRepositoryShop {
  Future<UseCaseGeneric<ModelPagedList<ModelShopList>>> getShopList({
    required int currentPage,
    required int pageSize,
    String? search,
  });

  Future<UseCaseGeneric<ModelShopDetails>> getShopDetailsUser({
    required String shopId,
  });

  Future<UseCaseGeneric<ModelPagedList<ModelPriceListUser>>> getPriceListUser({
    required String shopId,
    required int currentPage,
    required int pageSize,
    String? search,
  });
}

class RepositoryShop implements IRepositoryShop {
  final IApiGetShopList apiGetShopList;
  final IApiGetShopDetailsUser apiGetShopDetailsUser;
  final IApiGetPriceListUser apiGetPriceListUser;

  const RepositoryShop({
    required this.apiGetShopList,
    required this.apiGetShopDetailsUser,
    required this.apiGetPriceListUser,
  });

  @override
  Future<UseCaseGeneric<ModelPagedList<ModelShopList>>> getShopList({
    required int currentPage,
    required int pageSize,
    String? search,
  }) async {
    try {
      var (modelSopList, modelError) = await apiGetShopList.getShopList(
        currentPage: currentPage,
        pageSize: pageSize,
        search: search,
      );
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

  @override
  Future<UseCaseGeneric<ModelPagedList<ModelPriceListUser>>> getPriceListUser({
    required String shopId,
    required int currentPage,
    required int pageSize,
    String? search,
  }) async {
    try {
      var (modelPriceListUser, modelError) = await apiGetPriceListUser
          .getPriceList(
            shopId: shopId,
            currentPage: currentPage,
            pageSize: pageSize,
            search: search,
          );
      if (modelError == null) {
        return UseCaseGeneric(isSuccess: true, data: modelPriceListUser);
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }
}
