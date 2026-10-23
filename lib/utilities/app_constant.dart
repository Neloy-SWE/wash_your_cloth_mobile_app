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
  static const String otpRequestId = "otpRequestId";
  static const String recordId = "recordId";
  static const String ownerFirstName = "ownerFirstName";
  static const String ownerLastName = "ownerLastName";
  static const String shopAddress = "shopAddress";
  static const String shopName = "shopName";
  static const String openTime = "openTime";
  static const String closeTime = "closeTime";
  static const String weekends = "weekends";
  static const String price = "price";
  static const String discountPrice = "discountPrice";
  static const String ironPressPrice = "ironPressPrice";
  static const String priceId = "priceId";
  static const String serviceName = "serviceName";
  static const String description = "description";
  static const String serviceId = "serviceId";
  static const String itemName = "itemName";
  static const String itemId = "itemId";
  static const String orderDetails = "orderDetails";
  static const String pending = "pending";
  static const String accepted = "accepted";
  static const String ready = "ready";
  static const String handoverRequest = "handoverRequest";
}

enum Role { user, shop }

// enum OTPNavigation { updatePhone, updatePassword, registration }

enum DialogueType { loader, question, result }

enum Status {
  pending,
  accepted,
  rejected,
  ready,
  handoverRequest,
  received,
  delivered,
  open,
  close,
}

enum OrderStatusAction { accepted, rejected, ready, handoverRequest, received }
