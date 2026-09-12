/* 
Created by Neloy on 12 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of "profile_update_user_bloc.dart";

sealed class ProfileUpdateUserState extends Equatable {
  const ProfileUpdateUserState();

  @override
  List<Object?> get props => [];
}

class ProfileUpdateUserStateInitial extends ProfileUpdateUserState {}

class ProfileUpdateUserStateLoading extends ProfileUpdateUserState {}

class ProfileUpdateUserStateResult extends ProfileUpdateUserState {
  final bool isNavigate;
  final String message;

  const ProfileUpdateUserStateResult({
    required this.message,
    required this.isNavigate,
  });

  @override
  List<Object?> get props => [message, isNavigate];
}
