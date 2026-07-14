/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class ApiPath {
  // authentication
  static const String auth = "/auth";
  static const String refreshToken = "$auth/refresh-token";
  static const String login = "$auth/login";
  static const String registration = "$auth/registration";
  static const String otpVerify = "$auth/otp-verify";
}