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
  static const String logout = "$auth/logout";

  // order
  static const String order = "/order";
  static const String orderList = "$order/list";
  static const String orderDetailsUser = "$order/details-user/";
  static const String orderDetailsShop = "$order/details-shop/";
  static const String place = "$order/place/";
  static const String orderAccept = "$order/accept/";
  static const String orderReject = "$order/reject/";
  static const String orderReady = "$order/ready/";
  static const String orderHandoverRequest = "$order/handover-request/";
  static const String orderConfirmReceived = "$order/confirm-received/";

  // shop
  static const String shop = "/shop";
  static const String shopList = "$shop/list";
  static const String shopDetails = "$shop/details/";
  static const String viewShop = "$shop/view";
  static const String updateShop = "$shop/update";

  // resource
  static const String resource = "/resource";
  static const String priceListUser = "$resource/price-list-user/";
  static const String priceListShop = "$resource/price-list-shop";
  static const String priceActivation = "$resource/price-activation/";
  static const String priceAdd = "$resource/price-add";
  static const String priceUpdate = "$resource/price-update/";
  static const String serviceList = "$resource/service-list";
  static const String serviceActivation = "$resource/service-activation/";
  static const String serviceUpdate = "$resource/service-update/";
  static const String serviceAdd = "$resource/service-add";
  static const String itemList = "$resource/item-list";
  static const String itemActivation = "$resource/item-activation/";
  static const String itemUpdate = "$resource/item-update/";
  static const String itemAdd = "$resource/item-add";

  // user
  static const String user = "/user";
  static const viewUser = "$user/view";
  static const updateUser = "$user/update";
  static const changePassword = "$user/change-password";
  static const changePhone = "$user/change-phone";

  // notification
  static const String notification = "/notification";
  static const String notificationList = "$notification/list";
  static const String notificationUnreadCount = "$notification/unread-count";
  static const String notificationRead = "$notification/read/";
}
