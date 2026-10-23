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

// class GlobalEventSetOTPNavigation extends GlobalEvent {
//   final OTPNavigation otpNavigation;
//
//   GlobalEventSetOTPNavigation({required this.otpNavigation});
// }

// class GlobalEventSetPhone extends GlobalEvent {
//   final String phone;
//
//   GlobalEventSetPhone({required this.phone});
// }

class GlobalEventGetLoginStatus extends GlobalEvent {}

class GlobalEventLogoutCompleted extends GlobalEvent {}

class GlobalEventSessionExpired extends GlobalEvent {
  final bool deferRedirectUntilResultDismissed;

  GlobalEventSessionExpired({required this.deferRedirectUntilResultDismissed});
}

// class GlobalEventSetProfile extends GlobalEvent {}

// class GlobalEventUpdateProfile extends GlobalEvent {}

// class GlobalEventSetOTPInfo extends GlobalEvent {
//   final String otpRequestId;
//   final String recordId;
//
//   GlobalEventSetOTPInfo({required this.otpRequestId, required this.recordId});
// }
