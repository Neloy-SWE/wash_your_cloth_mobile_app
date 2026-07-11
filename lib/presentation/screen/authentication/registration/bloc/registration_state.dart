/* 
Created by Neloy on 10 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object?> get props => [];
}

class RegistrationStateInitial extends RegistrationState {}

class RegistrationStateLoading extends RegistrationState {}

class RegistrationStateNavigateOTP extends RegistrationState {
  final String otpRequestId;
  final String recordId;
  final String message;

  const RegistrationStateNavigateOTP({
    required this.otpRequestId,
    required this.recordId,
    required this.message,
  });

  @override
  List<Object?> get props => [otpRequestId, recordId];
}

class RegistrationStateResult extends RegistrationState {
  final String message;

  const RegistrationStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
