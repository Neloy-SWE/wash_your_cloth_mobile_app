/* 
Created by Neloy on 26 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class RequestProfileUpdateShop {
  final String ownerFirstName;
  final String ownerLastName;
  final String shopAddress;

  // final String longitude;
  // final String latitude;

  final String shopName;
  final String openTime;
  final String closeTime;
  final String weekends;
  final double deliveryCharge;

  RequestProfileUpdateShop({
    required this.ownerFirstName,
    required this.ownerLastName,
    required this.shopAddress,
    // required this.longitude,
    // required this.latitude,
    required this.shopName,
    required this.openTime,
    required this.closeTime,
    required this.weekends,
    required this.deliveryCharge,
  });

  Map<String, dynamic> toMap() => {
    'ownerFirstName': ownerFirstName,
    'ownerLastName': ownerLastName,
    'shopAddress': shopAddress,
    // 'longitude': longitude,
    // 'latitude': latitude,
    "longitude": "1234.55",
    "latitude": "1234.55",
    "shopName": shopName,
    "openTime": openTime,
    "closeTime": closeTime,
    "weekends": weekends,
    "deliveryCharge": deliveryCharge,
  };
}
