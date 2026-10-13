/* 
Created by Neloy on 13 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelItemList {
  final String id;
  final String serviceName;
  final String description;
  final bool isActive;

  ModelItemList({
    required this.id,
    required this.serviceName,
    required this.description,
    required this.isActive,
  });

  factory ModelItemList.fromRawJson(String str) =>
      ModelItemList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelItemList.fromJson(Map<String, dynamic> json) =>
      ModelItemList(
        id: json["id"],
        serviceName: json["serviceName"],
        description: json["description"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serviceName": serviceName,
    "description": description,
    "isActive": isActive,
  };

  ModelItemList copyWith({
    String? id,
    String? serviceName,
    String? description,
    bool? isActive,
  }) {
    return ModelItemList(
      id: id ?? this.id,
      serviceName: serviceName ?? this.serviceName,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }
}
