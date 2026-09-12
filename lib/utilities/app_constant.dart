/* 
Created by Neloy on 18 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class AppConstant {
  static const String shopId = "shopId";
  static const String items = "items";
  static const String deliveryCharge = "deliveryCharge";
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String address = "address";
}

enum Role { user, shop }

enum OTPNavigation { updatePhone, updatePassword, registration }

enum DialogueType { loader, question, result }

enum Status { pending, accepted, rejected, ready, delivered, open, close }
