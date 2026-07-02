/* 
Created by Neloy on 30 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationStateInitial extends AuthenticationState {}

class AuthenticationStateLoading extends AuthenticationState {}

class AuthenticationStateNavigateOTP extends AuthenticationState {}

class AuthenticationStateNavigateLogin extends AuthenticationState {}

class AuthenticationStateResult extends AuthenticationState {
  final String message;

  const AuthenticationStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
