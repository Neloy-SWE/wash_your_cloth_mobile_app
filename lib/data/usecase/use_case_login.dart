/* 
Created by Neloy on 01 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class UseCaseLogin {
  bool isOTPRequired;
  bool isLogin;
  String? message;

  UseCaseLogin({
    required this.isOTPRequired,
    required this.isLogin,
    this.message,
  });
}
