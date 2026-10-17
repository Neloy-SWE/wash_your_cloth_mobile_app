/* 
Created by Neloy on 12 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelPriceUpdate {
  final String status;
  final String message;

  ModelPriceUpdate({required this.status, required this.message});

  factory ModelPriceUpdate.fromRawJson(String str) =>
      ModelPriceUpdate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelPriceUpdate.fromJson(Map<String, dynamic> json) =>
      ModelPriceUpdate(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}
