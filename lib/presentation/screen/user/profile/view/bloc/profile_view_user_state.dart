/* 
Created by Neloy on 30 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'profile_view_user_bloc.dart';

sealed class ProfileViewUserState extends Equatable {
  const ProfileViewUserState();

  @override
  List<Object?> get props => [];
}

class ProfileViewUserStateInitial extends ProfileViewUserState {}

class ProfileViewUserStateLoading extends ProfileViewUserState {}

class ProfileViewUserStateFetch extends ProfileViewUserState {
  final ModelProfileViewUser profileViewUser;

  const ProfileViewUserStateFetch({required this.profileViewUser});

  @override
  List<Object?> get props => [profileViewUser];
}

class ProfileViewUserStateResult extends ProfileViewUserState {
  final String message;

  const ProfileViewUserStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
