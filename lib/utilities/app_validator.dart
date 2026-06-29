/* 
Created by Neloy on 20 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class AppValidator {

  static const String validatePhone =
      "Please enter correct phone number";
  static const String validatorPassword = "Please check password";
  static const String validatorPasswordIsNotMatched =
      "Password is not matched";


  static bool isPhone(String? phone) {
    if (phone == null || phone.isEmpty || phone[0] == " ") return false;
    final RegExp phoneRegex = RegExp(r'^01\d{9}$');
    return phoneRegex.hasMatch(phone);
  }
}