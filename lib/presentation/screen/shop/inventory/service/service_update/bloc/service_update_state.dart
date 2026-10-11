/* 
Created by Neloy on 11 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'service_update_bloc.dart';

sealed class ServiceUpdateState extends Equatable {
  const ServiceUpdateState();

  @override
  List<Object?> get props => [];
}

class ServiceUpdateStateInitial extends ServiceUpdateState {}

class ServiceUpdateStateLoading extends ServiceUpdateState {}

class ServiceUpdateStateResult extends ServiceUpdateState {
  final bool isNavigate;
  final String message;

  const ServiceUpdateStateResult({
    required this.message,
    required this.isNavigate,
  });

  @override
  List<Object?> get props => [message, isNavigate];
}
