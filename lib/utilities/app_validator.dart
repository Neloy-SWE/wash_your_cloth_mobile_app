/* 
Created by Neloy on 20 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class AppValidator {
  static const String validatePhone = "Please enter correct phone number";
  static const String validatorPassword = "Please check password";
  static const String validatorPasswordIsNotMatched = "Password is not matched";
  static const String validatorName = "Please enter your name";
  static const String validatorShopName = "Please enter your shop name";
  static const String validatorOpenTime = "Please add shop open time";
  static const String validatorCloseTime = "Please add shop close time";
  static const String validatorAddress = "Please add address";
  static const String validatorWeekends = "Please select Weekend";

  static bool isPhone(String? phone) {
    if (phone == null || phone.isEmpty || phone[0] == " ") return false;
    final RegExp phoneRegex = RegExp(r'^01\d{9}$');
    return phoneRegex.hasMatch(phone);
  }
}
