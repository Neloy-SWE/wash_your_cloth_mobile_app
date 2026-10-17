/* 
Created by Neloy on 12 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelPriceAdd {
  final String status;
  final String message;

  ModelPriceAdd({required this.status, required this.message});

  factory ModelPriceAdd.fromRawJson(String str) =>
      ModelPriceAdd.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelPriceAdd.fromJson(Map<String, dynamic> json) =>
      ModelPriceAdd(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}
