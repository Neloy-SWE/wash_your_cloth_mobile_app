/* 
Created by Neloy on 28 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'global_bloc.dart';

class GlobalState {
  final Role? role;
  final OTPNavigation? otpNavigation;
  final String? phone;
  final bool? isLogin;

  GlobalState({this.role, this.otpNavigation, this.phone, this.isLogin});

  GlobalState copyWith({
    Role? role,
    OTPNavigation? otpNavigation,
    String? email,
    String? phone,
    bool? isLogin,
  }) {
    return GlobalState(
      role: role ?? this.role,
      otpNavigation: otpNavigation ?? this.otpNavigation,
      phone: phone ?? this.phone,
      isLogin: isLogin ?? this.isLogin,
    );
  }
}
