/* 
Created by Neloy on 30 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'profile_view_user_bloc.dart';

sealed class ProfileViewUserEvent extends Equatable {
  const ProfileViewUserEvent();

  @override
  List<Object?> get props => [];
}

class ProfileViewUserEventFetch extends ProfileViewUserEvent {}
