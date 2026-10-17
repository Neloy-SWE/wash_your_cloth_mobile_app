/* 
Created by Neloy on 13 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'service_add_bloc.dart';

sealed class ServiceAddEvent extends Equatable {
  const ServiceAddEvent();

  @override
  List<Object?> get props => [];
}

class ServiceAddEventSubmit extends ServiceAddEvent {
  final String serviceName;
  final String description;

  const ServiceAddEventSubmit({
    required this.serviceName,
    required this.description,
  });

  @override
  List<Object?> get props => [serviceName, description];
}
