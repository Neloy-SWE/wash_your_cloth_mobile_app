/* 
Created by Neloy on 30 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:wash_your_cloth_mobile_app/data/model/model_profile_view_user.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/profile/user/api_profile_view_user.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/use_case_generic.dart';

abstract class IRepositoryProfile {
  Future<UseCaseGeneric<ModelProfileViewUser>> getProfileUser();
}

class RepositoryProfile implements IRepositoryProfile {
  final IApiProfileViewUser apiProfileViewUser;

  const RepositoryProfile({required this.apiProfileViewUser});

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
}
