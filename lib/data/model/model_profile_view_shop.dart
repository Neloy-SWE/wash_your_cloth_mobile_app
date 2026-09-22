/* 
Created by Neloy on 22 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

import 'package:flutter/material.dart';

class ModelProfileViewShop {
  final String id;
  final String shopName;
  final String ownerFirstName;
  final String ownerLastName;
  final String shopPhone;
  final String shopAddress;
  final double longitude;
  final double latitude;
  final String openTime;
  final String closeTime;
  final String weekends;
  final bool status;
  final double deliveryCharge;
  final OrdersSummary ordersSummary;
  final double totalIncome;

  ModelProfileViewShop({
    required this.id,
    required this.shopName,
    required this.ownerFirstName,
    required this.ownerLastName,
    required this.shopPhone,
    required this.shopAddress,
    required this.longitude,
    required this.latitude,
    required this.openTime,
    required this.closeTime,
    required this.weekends,
    required this.status,
    required this.deliveryCharge,
    required this.ordersSummary,
    required this.totalIncome,
  });

  factory ModelProfileViewShop.fromRawJson(String str) =>
      ModelProfileViewShop.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelProfileViewShop.fromJson(Map<String, dynamic> json) =>
      ModelProfileViewShop(
        id: json["id"],
        shopName: json["shopName"],
        ownerFirstName: json["ownerFirstName"],
        ownerLastName: json["ownerLastName"],
        shopPhone: json["shopPhone"],
        shopAddress: json["shopAddress"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        weekends: json["weekends"],
        status: json["status"],
        deliveryCharge: json["deliveryCharge"]?.toDouble(),
        ordersSummary: OrdersSummary.fromJson(json["ordersSummary"]),
        totalIncome: json["totalIncome"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shopName": shopName,
    "ownerFirstName": ownerFirstName,
    "ownerLastName": ownerLastName,
    "shopPhone": shopPhone,
    "shopAddress": shopAddress,
    "longitude": longitude,
    "latitude": latitude,
    "openTime": openTime,
    "closeTime": closeTime,
    "weekends": weekends,
    "status": status,
    "deliveryCharge": deliveryCharge,
    "ordersSummary": ordersSummary.toJson(),
    "totalIncome": totalIncome,
  };
}

class OrdersSummary {
  final int pending;
  final int accepted;
  final int ready;
  final int delivered;
  final int rejected;
  final int totalOrders;

  OrdersSummary({
    required this.pending,
    required this.accepted,
    required this.ready,
    required this.delivered,
    required this.rejected,
    required this.totalOrders,
  });

  factory OrdersSummary.fromRawJson(String str) =>
      OrdersSummary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrdersSummary.fromJson(Map<String, dynamic> json) => OrdersSummary(
    pending: json["pending"],
    accepted: json["accepted"],
    ready: json["ready"],
    delivered: json["delivered"],
    rejected: json["rejected"],
    totalOrders: json["totalOrders"],
  );

  Map<String, dynamic> toJson() => {
    "pending": pending,
    "accepted": accepted,
    "ready": ready,
    "delivered": delivered,
    "rejected": rejected,
    "totalOrders": totalOrders,
  };

  List<SummaryItem> toItemList() {
    return [
      SummaryItem(
        title: 'Total Orders',
        count: totalOrders,
        color: Colors.blue,
      ),
      SummaryItem(title: 'Pending', count: pending, color: Colors.amber),
      SummaryItem(title: 'Accepted', count: accepted, color: Colors.purple),
      SummaryItem(title: 'Ready', count: ready, color: Colors.cyan),
      SummaryItem(title: 'Delivered', count: delivered, color: Colors.green),
      SummaryItem(title: 'Rejected', count: rejected, color: Colors.red),
    ];
  }
}

class SummaryItem {
  final String title;
  final int count;
  final Color color;

  SummaryItem({required this.title, required this.count, required this.color});
}
