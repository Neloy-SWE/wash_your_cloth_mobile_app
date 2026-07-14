/* 
Created by Neloy on 11 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'otp_bloc.dart';

sealed class OTPEvent extends Equatable {
  const OTPEvent();

  @override
  List<Object?> get props => [];
}

class OTPEventVerify extends OTPEvent {
  final String otpRequestId;
  final String recordId;
  final String otpCode;

  const OTPEventVerify({
    required this.otpRequestId,
    required this.recordId,
    required this.otpCode,
  });

  @override
  List<Object?> get props => [otpRequestId, recordId, otpCode];
}
