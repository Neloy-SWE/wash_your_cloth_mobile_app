/* 
Created by Neloy on 20 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class AppValidator {
  static const String validatePhone = "Please enter correct phone number";
  static const String validatorPassword = "Please check password";
  static const String validatorIsPasswordMatched =
      "Old & new password cannot be same";
  static const String validatorIsPhoneMatched =
      "Old & new phone cannot be same";
  static const String validatorPasswordIsNotMatched = "Password is not matched";
  static const String validatorName = "Please enter your name";
  static const String validatorShopName = "Please enter your shop name";
  static const String validatorOpenTime = "Please add shop open time";
  static const String validatorCloseTime = "Please add shop close time";
  static const String validatorAddress = "Please add address";
  static const String validatorWeekends = "Please select Weekend";
  static const String validatorOTP = "Please add full otp code";
  static const String validatorDeliveryCharge =
      "Please add delivery charge amount";
  static const String validatorPrice = "Please add price";
  static const String validatorDiscountPrice = "Please add discount price";
  static const String validatorIronPressPrice = "Please add iron press price";
  static const String validatorProfileUpdate =
      "You haven't updated any profile data yet";
  static const String validatorPriceUpdate =
      "You haven't updated any price data yet";
  static const String validatorServiceUpdate =
      "You haven't updated any service data yet";
  static const String validatorProfileFetchFail =
      "Failed to get updated profile";
  static const String validatorInvalidPrice =
      "You are looking for an invalid price";
  static const String validatorInvalidService =
      "You are looking for an invalid service";
  static const String validatorPriceUpdateFail = "Failed to get update price";
  static const String validatorServiceUpdateFail =
      "Failed to get update service";
  static const String validatorServiceAddFail =
      "Failed to add new service";
  static const String validatorInvalidDropdownSelect =
      "Please select a valid option from the list";
  static const String validatorServiceName = "Please enter service name";
  static const String validatorDescription = "Description must be between 10 and 500 characters.";

  // bool checkInitialNullEmpty(String? value) {
  //   if (value == null || value.isEmpty || value[0] == " ") {
  //     return false;
  //   }
  //   return true;
  // }

  static bool isPhone(String? phone) {
    if (phone == null || phone.isEmpty || phone[0] == " ") return false;
    final RegExp phoneRegex = RegExp(r'^01\d{9}$');
    return phoneRegex.hasMatch(phone);
  }

  static bool isName(String? name) {
    if (name == null || name.isEmpty || name[0] == " ") return false;
    final RegExp nameRegex = RegExp(r"^[a-zA-Z\p{L} .]+$", unicode: true);
    return nameRegex.hasMatch(name);
  }

  static bool isAmount(String? amount) {
    if (amount == null || amount.isEmpty || amount[0] == " ") return false;
    return double.tryParse(amount) != null;
  }

  static bool isValidDescription(String? description) {
    if (description == null || description.isEmpty || description[0] == " ")
      return false;
    final int length = description.trim().length;
    return length >= 10 && length <= 500;
  }
}
