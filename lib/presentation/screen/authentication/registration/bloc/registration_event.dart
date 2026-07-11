/* 
Created by Neloy on 10 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

class RegistrationEventRegistration extends RegistrationEvent {
  final String? role;
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? phone;
  final String? password;
  final String? shopName;
  final String? openTime;
  final String? closeTime;
  final String? weekends;

  const RegistrationEventRegistration({
    this.role,
    this.firstName,
    this.lastName,
    this.address,
    this.phone,
    this.password,
    this.shopName,
    this.openTime,
    this.closeTime,
    this.weekends,
  });

  @override
  List<Object?> get props => [
    role,
    firstName,
    lastName,
    address,
    phone,
    password,
    shopName,
    openTime,
    closeTime,
    weekends,
  ];
}
