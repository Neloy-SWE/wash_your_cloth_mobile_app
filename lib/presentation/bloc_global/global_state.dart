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
  final String? otpRequestId;
  final String? recordId;

  GlobalState({
    this.role,
    this.otpNavigation,
    this.phone,
    this.isLogin,
    this.otpRequestId,
    this.recordId,
  });

  GlobalState copyWith({
    Role? role,
    OTPNavigation? otpNavigation,
    String? email,
    String? phone,
    bool? isLogin,
    String? otpRequestId,
    String? recordId,
  }) {
    return GlobalState(
      role: role ?? this.role,
      otpNavigation: otpNavigation ?? this.otpNavigation,
      phone: phone ?? this.phone,
      isLogin: isLogin ?? this.isLogin,
      otpRequestId: otpRequestId ?? this.otpRequestId,
      recordId: recordId ?? this.recordId,
    );
  }
}
