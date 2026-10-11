/* 
Created by Neloy on 02 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:wash_your_cloth_mobile_app/data/network/api_call/resource/shop/price/api_get_price_list_shop.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/resource/shop/price/api_price_activation.dart';

import '../model/model_price_list_shop.dart';
import '../model/model_service_list.dart';
import '../network/api_call/resource/shop/price/api_price_update.dart';
import '../network/api_call/resource/shop/service/api_get_service_list.dart';
import '../request/request_update_price.dart';
import '../use_case/use_case_generic.dart';

abstract class IRepositoryShopInventory {
  Future<UseCaseGeneric<List<ModelPriceListShop>>> getPriceListShop();

  Future<UseCaseGeneric<List<ModelServiceList>>> getServiceList();

  Future<UseCaseGeneric> priceActivation({required String priceId});

  Future<UseCaseGeneric> priceUpdate({
    required RequestUpdatePrice updatePrice,
    required String priceId,
  });
}

class RepositoryShopInventory implements IRepositoryShopInventory {
  final IApiGetPriceListShop apiGetPriceListShop;
  final IApiPriceActivation apiPriceActivation;
  final IApiPriceUpdate apiPriceUpdate;
  final IApiGetServiceList apiGetServiceList;

  RepositoryShopInventory({
    required this.apiGetPriceListShop,
    required this.apiPriceActivation,
    required this.apiPriceUpdate,
    required this.apiGetServiceList,
  });

  @override
  Future<UseCaseGeneric<List<ModelPriceListShop>>> getPriceListShop() async {
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

  @override
  Future<UseCaseGeneric> priceActivation({required String priceId}) async {
    try {
      var (modelPriceActivation, modelError) = await apiPriceActivation
          .priceActivation(priceId: priceId);

      if (modelError == null) {
        return UseCaseGeneric(
          isSuccess: true,
          message: modelPriceActivation?.message,
        );
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric> priceUpdate({
    required RequestUpdatePrice updatePrice,
    required String priceId,
  }) async {
    try {
      var (modelPriceUpdate, modelError) = await apiPriceUpdate.priceUpdate(
        data: updatePrice.toMap(),
        priceId: priceId,
      );

      if (modelError == null) {
        return UseCaseGeneric(
          isSuccess: true,
          message: modelPriceUpdate?.message,
        );
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric<List<ModelServiceList>>> getServiceList() async {
    try {
      var (modelServiceList, modelError) = await apiGetServiceList
          .getServiceList();
      if (modelError == null) {
        return UseCaseGeneric(isSuccess: true, data: modelServiceList);
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }
}
