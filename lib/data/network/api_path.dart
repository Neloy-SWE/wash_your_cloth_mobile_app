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

  // order
  static const String order = "/order";
  static const String orderListUser = "$order/list-user";
  static const String orderDetailsUser = "$order/details-user/";
  static const String place = "$order/place/";

  // shop
  static const String shop = "/shop";
  static const String shopList = "$shop/list";
  static const String shopDetails = "$shop/details/";

  // resource
  static const String resource = "/resource";
  static const String priceListUser = "$resource/price-list-user/";

  // user
  static const String user = "/user";
  static const viewUser = "$user/view";
}
