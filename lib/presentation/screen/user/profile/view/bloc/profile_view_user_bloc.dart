/* 
Created by Neloy on 30 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/repository/repository_profile.dart';
import 'package:wash_your_cloth_mobile_app/data/use_case/use_case_generic.dart';

import '../../../../../../data/client/client_constant.dart';
import '../../../../../../data/model/model_profile_view_user.dart';

part 'profile_view_user_event.dart';

part 'profile_view_user_state.dart';

class ProfileViewUserBloc
    extends Bloc<ProfileViewUserEvent, ProfileViewUserState> {
  final IRepositoryProfile repositoryProfile;

  ProfileViewUserBloc({required this.repositoryProfile})
    : super(ProfileViewUserStateInitial()) {
    on<ProfileViewUserEventFetch>(_onProfileViewUserEventFetch);
  }

  Future<void> _onProfileViewUserEventFetch(
    ProfileViewUserEventFetch event,
    Emitter<ProfileViewUserState> emit,
  ) async {
    emit(ProfileViewUserStateLoading());
    try {
      UseCaseGeneric<ModelProfileViewUser> useCaseProfileView =
          await repositoryProfile.getProfileUser();
      if (useCaseProfileView.isSuccess) {
        emit(
          ProfileViewUserStateFetch(profileViewUser: useCaseProfileView.data!),
        );
      } else {
        emit(ProfileViewUserStateResult(message: useCaseProfileView.message!));
      }
    } catch (e) {
      emit(ProfileViewUserStateResult(message: ClientConstant.serverError));
    }
  }
}
