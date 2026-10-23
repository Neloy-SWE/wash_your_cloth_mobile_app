/*
Created by Neloy on 23 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'logout_bloc.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object?> get props => [];
}

class LogoutStateInitial extends LogoutState {
  const LogoutStateInitial();
}

class LogoutStateLoading extends LogoutState {
  const LogoutStateLoading();
}

class LogoutStateSuccess extends LogoutState {
  final String message;

  const LogoutStateSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class LogoutStateFailure extends LogoutState {
  final String message;

  const LogoutStateFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
