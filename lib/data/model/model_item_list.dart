/* 
Created by Neloy on 13 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelItemList {
  final String id;
  final String itemName;
  final bool isActive;

  ModelItemList({
    required this.id,
    required this.itemName,
    required this.isActive,
  });

  factory ModelItemList.fromRawJson(String str) =>
      ModelItemList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelItemList.fromJson(Map<String, dynamic> json) =>
      ModelItemList(
        id: json["id"],
        itemName: json["itemName"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "itemName": itemName,
    "isActive": isActive,
  };

  ModelItemList copyWith({
    String? id,
    String? itemName,
    String? description,
    bool? isActive,
  }) {
    return ModelItemList(
      id: id ?? this.id,
      itemName: itemName ?? this.itemName,
      isActive: isActive ?? this.isActive,
    );
  }
}
