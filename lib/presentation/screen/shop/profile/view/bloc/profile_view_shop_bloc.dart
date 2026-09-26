/* 
Created by Neloy on 30 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/repository/repository_profile.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/use_case_generic.dart';

import '../../../../../../data/client/client_constant.dart';
import '../../../../../../data/model/model_profile_view_shop.dart';
import '../../../../../../data/model/model_profile_view_user.dart';

part 'profile_view_shop_event.dart';

part 'profile_view_shop_state.dart';

class ProfileViewShopBloc
    extends Bloc<ProfileViewShopEvent, ProfileViewShopState> {
  final IRepositoryProfile repositoryProfile;

  ProfileViewShopBloc({required this.repositoryProfile})
    : super(ProfileViewShopStateInitial()) {
    on<ProfileViewShopEventFetch>(_onProfileViewShopEventFetch);
  }

  Future<void> _onProfileViewShopEventFetch(
    ProfileViewShopEventFetch event,
    Emitter<ProfileViewShopState> emit,
  ) async {
    emit(ProfileViewShopStateLoading());
    try {
      UseCaseGeneric<ModelProfileViewShop> useCaseProfileView =
          await repositoryProfile.getProfileShop();
      if (useCaseProfileView.isSuccess) {
        emit(
          ProfileViewShopStateFetch(profileViewShop: useCaseProfileView.data!),
        );
      } else {
        emit(ProfileViewShopStateResult(message: useCaseProfileView.message!));
      }
    } catch (e) {
      emit(ProfileViewShopStateResult(message: ClientConstant.serverError));
    }
  }
}
