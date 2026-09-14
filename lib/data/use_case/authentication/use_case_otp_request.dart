/* 
Created by Neloy on 13 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class UseCaseOTPRequest {
  String? message;
  String? otpRequestId;
  String? recordId;
  bool isNavigateOTP;

  UseCaseOTPRequest({
    this.recordId,
    this.otpRequestId,
    this.message,
    required this.isNavigateOTP,
  });
}
