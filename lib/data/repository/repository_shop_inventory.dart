/* 
Created by Neloy on 02 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import '../model/model_item_list.dart';
import '../model/model_price_list_shop.dart';
import '../model/model_service_list.dart';
import '../model/model_paged_list.dart';
import '../network/api_call/resource/shop/item/api_get_item_list.dart';
import '../network/api_call/resource/shop/item/api_item_activation.dart';
import '../network/api_call/resource/shop/item/api_item_add.dart';
import '../network/api_call/resource/shop/item/api_item_update.dart';
import '../network/api_call/resource/shop/price/api_get_price_list_shop.dart';
import '../network/api_call/resource/shop/price/api_price_activation.dart';
import '../network/api_call/resource/shop/price/api_price_add.dart';
import '../network/api_call/resource/shop/price/api_price_update.dart';
import '../network/api_call/resource/shop/service/api_get_service_list.dart';
import '../network/api_call/resource/shop/service/api_service_activation.dart';
import '../network/api_call/resource/shop/service/api_service_add.dart';
import '../network/api_call/resource/shop/service/api_service_update.dart';
import '../request/request_item.dart';
import '../request/request_price_add.dart';
import '../request/request_price_update.dart';
import '../request/request_service.dart';
import '../use_case/use_case_generic.dart';

abstract class IRepositoryShopInventory {
  Future<UseCaseGeneric<ModelPagedList<ModelPriceListShop>>> getPriceListShop({
    required int currentPage,
    required int pageSize,
    String? search,
  });

  Future<UseCaseGeneric<ModelPagedList<ModelServiceList>>> getServiceList({
    required int currentPage,
    required int pageSize,
    String? search,
  });

  Future<UseCaseGeneric> priceActivation({required String priceId});

  Future<UseCaseGeneric> serviceActivation({required String serviceId});

  Future<UseCaseGeneric> priceUpdate({
    required RequestPriceUpdate updatePrice,
    required String priceId,
  });

  Future<UseCaseGeneric> serviceUpdate({
    required RequestService updateService,
    required String serviceId,
  });

  Future<UseCaseGeneric> serviceAdd({required RequestService serviceAdd});

  Future<UseCaseGeneric<ModelPagedList<ModelItemList>>> getItemList({
    required int currentPage,
    required int pageSize,
    String? search,
  });

  Future<UseCaseGeneric> itemActivation({required String itemId});

  Future<UseCaseGeneric> itemUpdate({
    required RequestItem updateItem,
    required String itemId,
  });

  Future<UseCaseGeneric> itemAdd({required RequestItem itemAdd});

  Future<UseCaseGeneric> priceAdd({required RequestPriceAdd priceAdd});
}

class RepositoryShopInventory implements IRepositoryShopInventory {
  final IApiGetPriceListShop apiGetPriceListShop;
  final IApiPriceActivation apiPriceActivation;
  final IApiPriceUpdate apiPriceUpdate;
  final IApiPriceAdd apiPriceAdd;

  final IApiServiceActivation apiServiceActivation;
  final IApiGetServiceList apiGetServiceList;
  final IApiServiceUpdate apiServiceUpdate;
  final IApiServiceAdd apiServiceAdd;

  final IApiItemActivation apiItemActivation;
  final IApiGetItemList apiGetItemList;
  final IApiItemUpdate apiItemUpdate;
  final IApiItemAdd apiItemAdd;

  RepositoryShopInventory({
    required this.apiGetPriceListShop,
    required this.apiPriceActivation,
    required this.apiServiceActivation,
    required this.apiPriceUpdate,
    required this.apiGetServiceList,
    required this.apiServiceUpdate,
    required this.apiServiceAdd,
    required this.apiItemActivation,
    required this.apiGetItemList,
    required this.apiItemUpdate,
    required this.apiItemAdd,
    required this.apiPriceAdd,
  });

  @override
  Future<UseCaseGeneric<ModelPagedList<ModelPriceListShop>>> getPriceListShop({
    required int currentPage,
    required int pageSize,
    String? search,
  }) async {
    try {
      var (modelPriceListShop, modelError) = await apiGetPriceListShop
          .getPriceList(
            currentPage: currentPage,
            pageSize: pageSize,
            search: search,
          );
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
    required RequestPriceUpdate updatePrice,
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
  Future<UseCaseGeneric<ModelPagedList<ModelServiceList>>> getServiceList({
    required int currentPage,
    required int pageSize,
    String? search,
  }) async {
    try {
      var (modelServiceList, modelError) = await apiGetServiceList
          .getServiceList(
            currentPage: currentPage,
            pageSize: pageSize,
            search: search,
          );
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

  @override
  Future<UseCaseGeneric<ModelPagedList<ModelItemList>>> getItemList({
    required int currentPage,
    required int pageSize,
    String? search,
  }) async {
    try {
      var (modelItemList, modelError) = await apiGetItemList.getItemList(
        currentPage: currentPage,
        pageSize: pageSize,
        search: search,
      );
      if (modelError == null) {
        return UseCaseGeneric(isSuccess: true, data: modelItemList);
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric<dynamic>> itemActivation({
    required String itemId,
  }) async {
    try {
      var (modelItemActivation, modelError) = await apiItemActivation
          .itemActivation(itemId: itemId);

      if (modelError == null) {
        return UseCaseGeneric(
          isSuccess: true,
          message: modelItemActivation?.message,
        );
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric<dynamic>> itemUpdate({
    required RequestItem updateItem,
    required String itemId,
  }) async {
    try {
      var (modelItemUpdate, modelError) = await apiItemUpdate.itemUpdate(
        data: updateItem.toMap(),
        itemId: itemId,
      );

      if (modelError == null) {
        return UseCaseGeneric(
          isSuccess: true,
          message: modelItemUpdate?.message,
        );
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric<dynamic>> itemAdd({
    required RequestItem itemAdd,
  }) async {
    try {
      var (modelItemAdd, modelError) = await apiItemAdd.itemAdd(
        data: itemAdd.toMap(),
      );

      if (modelError == null) {
        return UseCaseGeneric(isSuccess: true, message: modelItemAdd?.message);
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric<dynamic>> priceAdd({
    required RequestPriceAdd priceAdd,
  }) async {
    try {
      var (modelPriceAdd, modelError) = await apiPriceAdd.priceAdd(
        data: priceAdd.toMap(),
      );

      if (modelError == null) {
        return UseCaseGeneric(isSuccess: true, message: modelPriceAdd?.message);
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }
}
