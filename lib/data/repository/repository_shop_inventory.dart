/* 
Created by Neloy on 02 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import '../model/model_price_list_shop.dart';
import '../model/model_service_list.dart';
import '../network/api_call/resource/shop/price/api_get_price_list_shop.dart';
import '../network/api_call/resource/shop/price/api_price_activation.dart';
import '../network/api_call/resource/shop/price/api_price_update.dart';
import '../network/api_call/resource/shop/service/api_get_service_list.dart';
import '../network/api_call/resource/shop/service/api_service_activation.dart';
import '../network/api_call/resource/shop/service/api_service_add.dart';
import '../network/api_call/resource/shop/service/api_service_update.dart';
import '../request/request_update_price.dart';
import '../request/request_service.dart';
import '../use_case/use_case_generic.dart';

abstract class IRepositoryShopInventory {
  Future<UseCaseGeneric<List<ModelPriceListShop>>> getPriceListShop();

  Future<UseCaseGeneric<List<ModelServiceList>>> getServiceList();

  Future<UseCaseGeneric> priceActivation({required String priceId});

  Future<UseCaseGeneric> serviceActivation({required String serviceId});

  Future<UseCaseGeneric> priceUpdate({
    required RequestUpdatePrice updatePrice,
    required String priceId,
  });

  Future<UseCaseGeneric> serviceUpdate({
    required RequestService updateService,
    required String serviceId,
  });

  Future<UseCaseGeneric> serviceAdd({required RequestService serviceAdd});
}

class RepositoryShopInventory implements IRepositoryShopInventory {
  final IApiGetPriceListShop apiGetPriceListShop;
  final IApiPriceActivation apiPriceActivation;
  final IApiServiceActivation apiServiceActivation;
  final IApiPriceUpdate apiPriceUpdate;
  final IApiGetServiceList apiGetServiceList;
  final IApiServiceUpdate apiServiceUpdate;
  final IApiServiceAdd apiServiceAdd;

  RepositoryShopInventory({
    required this.apiGetPriceListShop,
    required this.apiPriceActivation,
    required this.apiServiceActivation,
    required this.apiPriceUpdate,
    required this.apiGetServiceList,
    required this.apiServiceUpdate,
    required this.apiServiceAdd,
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

  @override
  Future<UseCaseGeneric<dynamic>> serviceActivation({
    required String serviceId,
  }) async {
    try {
      var (modelServiceActivation, modelError) = await apiServiceActivation
          .serviceActivation(serviceId: serviceId);

      if (modelError == null) {
        return UseCaseGeneric(
          isSuccess: true,
          message: modelServiceActivation?.message,
        );
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric<dynamic>> serviceUpdate({
    required RequestService updateService,
    required String serviceId,
  }) async {
    try {
      var (modelServiceUpdate, modelError) = await apiServiceUpdate
          .serviceUpdate(data: updateService.toMap(), serviceId: serviceId);

      if (modelError == null) {
        return UseCaseGeneric(
          isSuccess: true,
          message: modelServiceUpdate?.message,
        );
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric<dynamic>> serviceAdd({
    required RequestService serviceAdd,
  }) async {
    try {
      var (modelServiceAdd, modelError) = await apiServiceAdd.serviceAdd(
        data: serviceAdd.toMap(),
      );

      if (modelError == null) {
        return UseCaseGeneric(
          isSuccess: true,
          message: modelServiceAdd?.message,
        );
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }
}
