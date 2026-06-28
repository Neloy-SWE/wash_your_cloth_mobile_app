/* 
Created by Neloy on 28 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'global_bloc.dart';

class GlobalState {
  final Role? role;
  final OTPNavigation? otpNavigation;
  final String? phone;

  GlobalState({this.role, this.otpNavigation, this.phone});

  GlobalState copyWith({
    Role? role,
    OTPNavigation? otpNavigation,
    String? email,
    String? phone,
  }) {
    return GlobalState(
      role: role ?? this.role,
      otpNavigation: otpNavigation ?? this.otpNavigation,
      phone: phone ?? this.phone,
    );
  }
}
