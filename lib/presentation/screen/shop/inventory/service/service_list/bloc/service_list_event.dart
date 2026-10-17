/* 
Created by Neloy on 10 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'service_list_bloc.dart';

sealed class ServiceListEvent extends Equatable {
  const ServiceListEvent();

  @override
  List<Object?> get props => [];
}

class ServiceListEventFetch extends ServiceListEvent {}

class ServiceListEventActivation extends ServiceListEvent {
  final String serviceId;

  const ServiceListEventActivation({required this.serviceId});

  @override
  List<Object?> get props => [serviceId];
}

class ServiceListEventUpdate extends ServiceListEvent {
  final String description;
  final String serviceName;
  final String serviceId;

  const ServiceListEventUpdate({
    required this.description,
    required this.serviceName,
    required this.serviceId,
  });

  @override
  List<Object?> get props => [description, serviceName, serviceId];
}
