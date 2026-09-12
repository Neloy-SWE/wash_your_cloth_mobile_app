/* 
Created by Neloy on 12 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'profile_update_user_bloc.dart';

sealed class ProfileUpdateUserEvent extends Equatable {
  const ProfileUpdateUserEvent();

  @override
  List<Object?> get props => [];
}

class ProfileUpdateUserEventSubmit extends ProfileUpdateUserEvent {
  final String firstName;
  final String lastName;
  final String address;

  const ProfileUpdateUserEventSubmit({
    required this.firstName,
    required this.lastName,
    required this.address,
  });

  @override
  List<Object?> get props => [firstName, lastName, address];
}
