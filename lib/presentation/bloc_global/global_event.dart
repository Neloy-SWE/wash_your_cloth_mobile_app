/* 
Created by Neloy on 28 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'global_bloc.dart';

sealed class GlobalEvent {}

class GlobalEventSetRole extends GlobalEvent {
  final Role role;

  GlobalEventSetRole({required this.role});
}

class GlobalEventSetOTPNavigation extends GlobalEvent {
  final OTPNavigation otpNavigation;

  GlobalEventSetOTPNavigation({required this.otpNavigation});
}

class GlobalEventSetPhone extends GlobalEvent {
  final String phone;

  GlobalEventSetPhone({required this.phone});
}

class GlobalEventGetLoginStatus extends GlobalEvent {}

class GlobalEventSetProfile extends GlobalEvent {}

class GlobalEventUpdateProfile extends GlobalEvent {}
