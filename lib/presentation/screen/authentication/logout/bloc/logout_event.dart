/*
Created by Neloy on 23 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'logout_bloc.dart';

sealed class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}

class LogoutEventRequested extends LogoutEvent {
  final bool allDevices;

  const LogoutEventRequested({required this.allDevices});

  @override
  List<Object?> get props => [allDevices];
}
