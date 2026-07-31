/* 
Created by Neloy on 25 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelShopList {
  final String id;
  final String shopName;
  final bool status;
  final String shopAddress;

  ModelShopList({
    required this.id,
    required this.shopName,
    required this.status,
    required this.shopAddress,
  });

  factory ModelShopList.fromRawJson(String str) =>
      ModelShopList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelShopList.fromJson(Map<String, dynamic> json) => ModelShopList(
    id: json["id"],
    shopName: json["shopName"],
    status: json["status"],
    shopAddress: json["shopAddress"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shopName": shopName,
    "status": status,
    "shopAddress": shopAddress,
  };
}
