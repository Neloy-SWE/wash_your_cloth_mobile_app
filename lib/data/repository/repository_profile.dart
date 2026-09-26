/* 
Created by Neloy on 30 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:wash_your_cloth_mobile_app/data/model/model_profile_view_user.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/profile/user/api_profile_view_user.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/use_case_generic.dart';

import '../model/model_profile_view_shop.dart';
import '../network/api_call/profile/shop/api_profile_update_shop.dart';
import '../network/api_call/profile/shop/api_profile_view_shop.dart';
import '../network/api_call/profile/user/api_profile_update_user.dart';
import '../request/request_profile_update_shop.dart';
import '../request/request_profile_update_user.dart';

abstract class IRepositoryProfile {
  Future<UseCaseGeneric<ModelProfileViewUser>> getProfileUser();

  Future<UseCaseGeneric> updateProfileUser({
    required RequestProfileUpdateUser update,
  });

  Future<UseCaseGeneric<ModelProfileViewShop>> getProfileShop();

  Future<UseCaseGeneric> updateProfileShop({
    required RequestProfileUpdateShop update,
  });
}

class RepositoryProfile implements IRepositoryProfile {
  final IApiProfileViewUser apiProfileViewUser;
  final IApiProfileViewShop apiProfileViewShop;
  final IApiProfileUpdateUser apiProfileUpdateUser;
  final IApiProfileUpdateShop apiProfileUpdateShop;

  const RepositoryProfile({
    required this.apiProfileViewUser,
    required this.apiProfileViewShop,
    required this.apiProfileUpdateUser,
    required this.apiProfileUpdateShop,
  });

  @override
  Future<UseCaseGeneric<ModelProfileViewUser>> getProfileUser() async {
    try {
      var (modelProfileViewUser, modelError) = await apiProfileViewUser
          .getProfileView();
      if (modelError == null) {
        return UseCaseGeneric(isSuccess: true, data: modelProfileViewUser);
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric> updateProfileUser({
    required RequestProfileUpdateUser update,
  }) async {
    try {
      var (modelProfileUpdateUser, modelError) = await apiProfileUpdateUser
          .updateProfile(data: update.toMap());

      if (modelError == null) {
        return UseCaseGeneric(
          isSuccess: true,
          message: modelProfileUpdateUser?.message,
        );
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric<ModelProfileViewShop>> getProfileShop() async {
    try {
      var (modelProfileViewShop, modelError) = await apiProfileViewShop
          .getProfileView();
      if (modelError == null) {
        return UseCaseGeneric(isSuccess: true, data: modelProfileViewShop);
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }

  @override
  Future<UseCaseGeneric<dynamic>> updateProfileShop({
    required RequestProfileUpdateShop update,
  }) async {
    try {
      var (modelProfileUpdateShop, modelError) = await apiProfileUpdateShop
          .updateProfile(data: update.toMap());

      if (modelError == null) {
        return UseCaseGeneric(
          isSuccess: true,
          message: modelProfileUpdateShop?.message,
        );
      } else {
        return UseCaseGeneric.fromModelError(modelError);
      }
    } catch (e) {
      return UseCaseGeneric.serverError();
    }
  }
}
