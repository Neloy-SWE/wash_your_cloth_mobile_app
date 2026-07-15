/* 
Created by Neloy on 11 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class OTPVerifyData {
  final String otpRequestId;
  final String recordId;
  final String otpCode;

  const OTPVerifyData({
    required this.otpRequestId,
    required this.recordId,
    required this.otpCode,
  });

  Map<String, dynamic> toMap() {
    return {
      "recordId": recordId,
      "otpRequestId": otpRequestId,
      "otpCode": otpCode,
    };
  }
}

class UseCaseOtpVerify {
  bool isVerify;
  String message;

  UseCaseOtpVerify({required this.isVerify, required this.message});
}
