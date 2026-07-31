/* 
Created by Neloy on 01 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelPriceListUser {
  final String serviceName;
  final String itemName;
  final double price;
  final double discountPrice;
  final double conveyancePrice;
  final double ironPressPrice;

  ModelPriceListUser({
    required this.serviceName,
    required this.itemName,
    required this.price,
    required this.discountPrice,
    required this.conveyancePrice,
    required this.ironPressPrice,
  });

  factory ModelPriceListUser.fromRawJson(String str) =>
      ModelPriceListUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelPriceListUser.fromJson(Map<String, dynamic> json) =>
      ModelPriceListUser(
        serviceName: json["serviceName"],
        itemName: json["itemName"],
        price: json["price"]?.toDouble(),
        discountPrice: json["discountPrice"]?.toDouble(),
        conveyancePrice: json["conveyancePrice"]?.toDouble(),
        ironPressPrice: json["ironPressPrice"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "serviceName": serviceName,
    "itemName": itemName,
    "price": price,
    "discountPrice": discountPrice,
    "conveyancePrice": conveyancePrice,
    "ironPressPrice": ironPressPrice,
  };
}
