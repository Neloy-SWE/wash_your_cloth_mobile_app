/* 
Created by Neloy on 18 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'change_phone_bloc.dart';

sealed class ChangePhoneState extends Equatable {
  const ChangePhoneState();

  @override
  List<Object?> get props => [];
}

class ChangePhoneStateInitial extends ChangePhoneState {}

class ChangePhoneStateLoading extends ChangePhoneState {}

class ChangePhoneStateNavigateOTP extends ChangePhoneState {
  final String otpRequestId;
  final String recordId;
  final String message;

  const ChangePhoneStateNavigateOTP({
    required this.otpRequestId,
    required this.recordId,
    required this.message,
  });

  @override
  List<Object?> get props => [otpRequestId, recordId, message];
}

class ChangePhoneStateResult extends ChangePhoneState {
  final String message;

  const ChangePhoneStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
