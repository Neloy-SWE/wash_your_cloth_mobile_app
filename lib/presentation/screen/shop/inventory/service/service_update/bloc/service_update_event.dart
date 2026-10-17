/* 
Created by Neloy on 11 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'service_update_bloc.dart';

sealed class ServiceUpdateEvent extends Equatable {
  const ServiceUpdateEvent();

  @override
  List<Object?> get props => [];
}

class ServiceUpdateEventSubmit extends ServiceUpdateEvent {
  final String serviceName;
  final String description;
  final String serviceId;

  const ServiceUpdateEventSubmit({
    required this.serviceName,
    required this.description,
    required this.serviceId,
  });

  @override
  List<Object?> get props => [serviceName, description, serviceId];
}
