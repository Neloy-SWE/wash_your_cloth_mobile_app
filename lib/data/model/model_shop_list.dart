/* 
Created by Neloy on 25 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelSopList {
  final String id;
  final String shopName;
  final bool status;
  final String shopAddress;

  ModelSopList({
    required this.id,
    required this.shopName,
    required this.status,
    required this.shopAddress,
  });

  factory ModelSopList.fromRawJson(String str) =>
      ModelSopList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelSopList.fromJson(Map<String, dynamic> json) => ModelSopList(
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
