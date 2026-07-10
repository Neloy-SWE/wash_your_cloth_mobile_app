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

class LoginStateNavigateOTP extends LoginState {}

class LoginStateNavigateLogin extends LoginState {}

class LoginStateResult extends LoginState {
  final String message;

  const LoginStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
