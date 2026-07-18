/* 
Created by Neloy on 17 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelOrderDetailsUser {
  final String id;
  final String trackingId;
  final String status;
  final int totalPrice;
  final String shopName;
  final String ownerFirstName;
  final String ownerLastName;
  final String shopAddress;
  final String shopPhone;
  final List<OrderItem> orderItems;

  ModelOrderDetailsUser({
    required this.id,
    required this.trackingId,
    required this.status,
    required this.totalPrice,
    required this.shopName,
    required this.ownerFirstName,
    required this.ownerLastName,
    required this.shopAddress,
    required this.shopPhone,
    required this.orderItems,
  });

  factory ModelOrderDetailsUser.fromRawJson(String str) => ModelOrderDetailsUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelOrderDetailsUser.fromJson(Map<String, dynamic> json) => ModelOrderDetailsUser(
    id: json["id"],
    trackingId: json["trackingId"],
    status: json["status"],
    totalPrice: json["totalPrice"],
    shopName: json["shopName"],
    ownerFirstName: json["ownerFirstName"],
    ownerLastName: json["ownerLastName"],
    shopAddress: json["shopAddress"],
    shopPhone: json["shopPhone"],
    orderItems: List<OrderItem>.from(json["OrderItems"].map((x) => OrderItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trackingId": trackingId,
    "status": status,
    "totalPrice": totalPrice,
    "shopName": shopName,
    "ownerFirstName": ownerFirstName,
    "ownerLastName": ownerLastName,
    "shopAddress": shopAddress,
    "shopPhone": shopPhone,
    "OrderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
  };
}

class OrderItem {
  final String id;
  final String serviceName;
  final String itemName;
  final int quantity;
  final int unitPrice;
  final bool isIronPress;
  final int ironPressPrice;
  final int totalPrice;

  OrderItem({
    required this.id,
    required this.serviceName,
    required this.itemName,
    required this.quantity,
    required this.unitPrice,
    required this.isIronPress,
    required this.ironPressPrice,
    required this.totalPrice,
  });

  factory OrderItem.fromRawJson(String str) => OrderItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    serviceName: json["serviceName"],
    itemName: json["itemName"],
    quantity: json["quantity"],
    unitPrice: json["unitPrice"],
    isIronPress: json["isIronPress"],
    ironPressPrice: json["ironPressPrice"],
    totalPrice: json["totalPrice"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serviceName": serviceName,
    "itemName": itemName,
    "quantity": quantity,
    "unitPrice": unitPrice,
    "isIronPress": isIronPress,
    "ironPressPrice": ironPressPrice,
    "totalPrice": totalPrice,
  };
}
