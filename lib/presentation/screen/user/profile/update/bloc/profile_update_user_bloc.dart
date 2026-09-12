/* 
Created by Neloy on 12 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/request/request_profile_update_user.dart';

import '../../../../../../data/client/client_constant.dart';
import '../../../../../../data/repository/repository_profile.dart';
import '../../../../../../data/use_case/use_case_generic.dart';

part 'profile_update_user_event.dart';

part 'profile_update_user_state.dart';

class ProfileUpdateUserBloc
    extends Bloc<ProfileUpdateUserEvent, ProfileUpdateUserState> {
  final IRepositoryProfile repositoryProfile;

  ProfileUpdateUserBloc({required this.repositoryProfile})
    : super(ProfileUpdateUserStateInitial()) {
    on<ProfileUpdateUserEventSubmit>(_onProfileUpdateUserEventSubmit);
  }

  Future<void> _onProfileUpdateUserEventSubmit(
    ProfileUpdateUserEventSubmit event,
    Emitter<ProfileUpdateUserState> emit,
  ) async {
    emit(ProfileUpdateUserStateLoading());
    try {
      RequestProfileUpdateUser updateUser = RequestProfileUpdateUser(
        firstName: event.firstName,
        lastName: event.lastName,
        address: event.address,
      );
      UseCaseGeneric useCaseGeneric = await repositoryProfile.updateProfile(
        update: updateUser,
      );
      emit(
        ProfileUpdateUserStateResult(
          message: useCaseGeneric.message!,
          isNavigate: useCaseGeneric.isSuccess,
        ),
      );
    } catch (e) {
      emit(
        ProfileUpdateUserStateResult(
          message: ClientConstant.serverError,
          isNavigate: false,
        ),
      );
    }
  }
}
