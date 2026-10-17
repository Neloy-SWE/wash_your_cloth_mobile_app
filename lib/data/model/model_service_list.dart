/* 
Created by Neloy on 10 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelServiceList {
  final String id;
  final String serviceName;
  final String description;
  final bool isActive;

  ModelServiceList({
    required this.id,
    required this.serviceName,
    required this.description,
    required this.isActive,
  });

  factory ModelServiceList.fromRawJson(String str) =>
      ModelServiceList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelServiceList.fromJson(Map<String, dynamic> json) =>
      ModelServiceList(
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

  ModelServiceList copyWith({
    String? id,
    String? serviceName,
    String? description,
    bool? isActive,
  }) {
    return ModelServiceList(
      id: id ?? this.id,
      serviceName: serviceName ?? this.serviceName,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }
}
