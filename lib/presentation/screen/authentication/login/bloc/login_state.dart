/* 
Created by Neloy on 30 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateNavigateOTP extends LoginState {
  final String otpRequestId;
  final String recordId;
  final String message;

  const LoginStateNavigateOTP({
    required this.otpRequestId,
    required this.recordId,
    required this.message,
  });

  @override
  List<Object?> get props => [otpRequestId, recordId];
}

class LoginStateNavigateLogin extends LoginState {}

class LoginStateResult extends LoginState {
  final String message;

  const LoginStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
