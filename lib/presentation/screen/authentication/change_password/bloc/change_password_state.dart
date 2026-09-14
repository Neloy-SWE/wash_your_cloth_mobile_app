/* 
Created by Neloy on 13 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'change_password_bloc.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

class ChangePasswordStateInitial extends ChangePasswordState {}

class ChangePasswordStateLoading extends ChangePasswordState {}

class ChangePasswordStateNavigateOTP extends ChangePasswordState {
  final String otpRequestId;
  final String recordId;
  final String message;

  const ChangePasswordStateNavigateOTP({
    required this.otpRequestId,
    required this.recordId,
    required this.message,
  });

  @override
  List<Object?> get props => [otpRequestId, recordId, message];
}

class ChangePasswordStateResult extends ChangePasswordState {
  final String message;

  const ChangePasswordStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
