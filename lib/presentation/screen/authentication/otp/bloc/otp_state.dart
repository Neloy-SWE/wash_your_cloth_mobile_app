/* 
Created by Neloy on 11 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'otp_bloc.dart';

sealed class OTPState extends Equatable {
  const OTPState();

  @override
  List<Object?> get props => [];
}

class OTPStateInitial extends OTPState {}

class OTPStateLoading extends OTPState {}

class OTPStateVerify extends OTPState {
  final String message;

  const OTPStateVerify({required this.message});

  @override
  List<Object?> get props => [message];
}

class OTPStateResult extends OTPState {
  final String message;

  const OTPStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
