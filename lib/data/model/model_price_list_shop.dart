/* 
Created by Neloy on 02 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelPriceListShop {
  final String id;
  final String serviceName;
  final String description;
  final String itemName;
  final double price;
  final double discountPrice;
  final double ironPressPrice;
  final bool isServiceActive;
  final bool isItemActive;
  final bool isActive;

  ModelPriceListShop({
    required this.id,
    required this.serviceName,
    required this.description,
    required this.itemName,
    required this.price,
    required this.discountPrice,
    required this.ironPressPrice,
    required this.isServiceActive,
    required this.isItemActive,
    required this.isActive,
  });

  factory ModelPriceListShop.fromRawJson(String str) =>
      ModelPriceListShop.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelPriceListShop.fromJson(Map<String, dynamic> json) =>
      ModelPriceListShop(
        id: json["id"],
        serviceName: json["serviceName"],
        description: json["description"],
        itemName: json["itemName"],
        price: json["price"]?.toDouble(),
        discountPrice: json["discountPrice"]?.toDouble(),
        ironPressPrice: json["ironPressPrice"]?.toDouble(),
        isServiceActive: json["isServiceActive"],
        isItemActive: json["isItemActive"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serviceName": serviceName,
    "description": description,
    "itemName": itemName,
    "price": price,
    "discountPrice": discountPrice,
    "ironPressPrice": ironPressPrice,
    "isServiceActive": isServiceActive,
    "isItemActive": isItemActive,
    "isActive": isActive,
  };
}
