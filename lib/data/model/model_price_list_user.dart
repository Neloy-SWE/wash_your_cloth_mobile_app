/* 
Created by Neloy on 01 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelPriceListUser {
  final String id;
  final String serviceName;
  final String itemName;
  final double price;
  final double discountPrice;
  final double ironPressPrice;

  ModelPriceListUser({
    required this.id,
    required this.serviceName,
    required this.itemName,
    required this.price,
    required this.discountPrice,
    required this.ironPressPrice,
  });

  factory ModelPriceListUser.fromRawJson(String str) =>
      ModelPriceListUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelPriceListUser.fromJson(Map<String, dynamic> json) =>
      ModelPriceListUser(
        id: json["id"],
        serviceName: json["serviceName"],
        itemName: json["itemName"],
        price: json["price"]?.toDouble(),
        discountPrice: json["discountPrice"]?.toDouble(),
        ironPressPrice: json["ironPressPrice"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serviceName": serviceName,
    "itemName": itemName,
    "price": price,
    "discountPrice": discountPrice,
    "ironPressPrice": ironPressPrice,
  };
}
