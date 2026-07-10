/* 
Created by Neloy on 30 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginEventLogin extends LoginEvent {
  final String phone;
  final String password;
  final String role;

  const LoginEventLogin({
    required this.phone,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [phone, password, role];
}
