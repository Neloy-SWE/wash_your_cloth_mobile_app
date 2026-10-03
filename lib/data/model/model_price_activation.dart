/* 
Created by Neloy on 03 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelPriceActivation {
  final String status;
  final String message;

  ModelPriceActivation({required this.status, required this.message});

  factory ModelPriceActivation.fromRawJson(String str) =>
      ModelPriceActivation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelPriceActivation.fromJson(Map<String, dynamic> json) =>
      ModelPriceActivation(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}
