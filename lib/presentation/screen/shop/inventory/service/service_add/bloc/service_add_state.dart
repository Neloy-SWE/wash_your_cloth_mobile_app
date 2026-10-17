/* 
Created by Neloy on 13 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'service_add_bloc.dart';

sealed class ServiceAddState extends Equatable {
  const ServiceAddState();

  @override
  List<Object?> get props => [];
}

class ServiceAddStateInitial extends ServiceAddState {}

class ServiceAddStateLoading extends ServiceAddState {}

class ServiceAddStateResult extends ServiceAddState {
  final bool isNavigate;
  final String message;

  const ServiceAddStateResult({
    required this.message,
    required this.isNavigate,
  });

  @override
  List<Object?> get props => [message, isNavigate];
}