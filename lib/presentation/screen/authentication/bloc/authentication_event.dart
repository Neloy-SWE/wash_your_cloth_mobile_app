/* 
Created by Neloy on 30 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationEventLogin extends AuthenticationEvent {
  final String phone;
  final String password;
  final String role;

  const AuthenticationEventLogin({
    required this.phone,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [phone, password, role];
}
