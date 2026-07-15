/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelOrderList {
  final String id;
  final String trackingId;
  final num totalPrice;
  final String status;

  ModelOrderList({
    required this.id,
    required this.trackingId,
    required this.totalPrice,
    required this.status,
  });

  factory ModelOrderList.fromRawJson(String str) =>
      ModelOrderList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelOrderList.fromJson(Map<String, dynamic> json) => ModelOrderList(
    id: json["id"],
    trackingId: json["trackingId"],
    totalPrice: json["totalPrice"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trackingId": trackingId,
    "totalPrice": totalPrice,
    "status": status,
  };
}
