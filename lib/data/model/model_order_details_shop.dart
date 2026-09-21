/* 
Created by Neloy on 21 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelOrderDetailsShop {
  final String id;
  final String trackingId;
  final String status;
  final int totalPrice;
  final int deliveryCharge;
  final String note;
  final String userFirstName;
  final String userLastName;
  final String userAddress;
  final String userPhone;
  final List<OrderItem> orderItems;

  ModelOrderDetailsShop({
    required this.id,
    required this.trackingId,
    required this.status,
    required this.totalPrice,
    required this.deliveryCharge,
    required this.note,
    required this.userFirstName,
    required this.userLastName,
    required this.userAddress,
    required this.userPhone,
    required this.orderItems,
  });

  factory ModelOrderDetailsShop.fromRawJson(String str) =>
      ModelOrderDetailsShop.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelOrderDetailsShop.fromJson(Map<String, dynamic> json) =>
      ModelOrderDetailsShop(
        id: json["id"],
        trackingId: json["trackingId"],
        status: json["status"],
        totalPrice: json["totalPrice"],
        deliveryCharge: json["deliveryCharge"],
        note: json["note"],
        userFirstName: json["userFirstName"],
        userLastName: json["userLastName"],
        userAddress: json["userAddress"],
        userPhone: json["userPhone"],
        orderItems: List<OrderItem>.from(
          json["OrderItems"].map((x) => OrderItem.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trackingId": trackingId,
    "status": status,
    "totalPrice": totalPrice,
    "deliveryCharge": deliveryCharge,
    "note": note,
    "userFirstName": userFirstName,
    "userLastName": userLastName,
    "userAddress": userAddress,
    "userPhone": userPhone,
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

  factory OrderItem.fromRawJson(String str) =>
      OrderItem.fromJson(json.decode(str));

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
