/* 
Created by Neloy on 31 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelShopDetails {
  final String id;
  final String shopName;
  final String ownerFirstName;
  final String ownerLastName;
  final String phone;
  final String shopAddress;
  final double longitude;
  final double latitude;
  final String openTime;
  final String closeTime;
  final String weekends;
  final bool status;

  ModelShopDetails({
    required this.id,
    required this.shopName,
    required this.ownerFirstName,
    required this.ownerLastName,
    required this.phone,
    required this.shopAddress,
    required this.longitude,
    required this.latitude,
    required this.openTime,
    required this.closeTime,
    required this.weekends,
    required this.status,
  });

  factory ModelShopDetails.fromRawJson(String str) =>
      ModelShopDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelShopDetails.fromJson(Map<String, dynamic> json) =>
      ModelShopDetails(
        id: json["id"],
        shopName: json["shopName"],
        ownerFirstName: json["ownerFirstName"],
        ownerLastName: json["ownerLastName"],
        phone: json["phone"],
        shopAddress: json["shopAddress"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        weekends: json["weekends"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shopName": shopName,
    "ownerFirstName": ownerFirstName,
    "ownerLastName": ownerLastName,
    "phone": phone,
    "shopAddress": shopAddress,
    "longitude": longitude,
    "latitude": latitude,
    "openTime": openTime,
    "closeTime": closeTime,
    "weekends": weekends,
    "status": status,
  };
}
