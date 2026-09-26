/* 
Created by Neloy on 12 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/request/request_profile_update_user.dart';

import '../../../../../../data/client/client_constant.dart';
import '../../../../../../data/repository/repository_profile.dart';
import '../../../../../../data/request/request_profile_update_shop.dart';
import '../../../../../../data/use_case/use_case_generic.dart';

part 'profile_update_shop_event.dart';

part 'profile_update_shop_state.dart';

class ProfileUpdateShopBloc
    extends Bloc<ProfileUpdateShopEvent, ProfileUpdateShopState> {
  final IRepositoryProfile repositoryProfile;

  ProfileUpdateShopBloc({required this.repositoryProfile})
    : super(ProfileUpdateShopStateInitial()) {
    on<ProfileUpdateShopEventSubmit>(_onProfileUpdateShopEventSubmit);
  }

  Future<void> _onProfileUpdateShopEventSubmit(
    ProfileUpdateShopEventSubmit event,
    Emitter<ProfileUpdateShopState> emit,
  ) async {
    emit(ProfileUpdateShopStateLoading());
    try {
      RequestProfileUpdateShop updateShop = RequestProfileUpdateShop(
        ownerFirstName: event.ownerFirstName,
        ownerLastName: event.ownerLastName,
        shopAddress: event.shopAddress,
        shopName: event.shopName,
        openTime: event.openTime,
        closeTime: event.closeTime,
        weekends: event.weekends,
        deliveryCharge: event.deliveryCharge,
      );
      UseCaseGeneric useCaseGeneric = await repositoryProfile.updateProfileShop(
        update: updateShop,
      );
      emit(
        ProfileUpdateShopStateResult(
          message: useCaseGeneric.message!,
          isNavigate: useCaseGeneric.isSuccess,
        ),
      );
    } catch (e) {
      emit(
        ProfileUpdateShopStateResult(
          message: ClientConstant.serverError,
          isNavigate: false,
        ),
      );
    }
  }
}
