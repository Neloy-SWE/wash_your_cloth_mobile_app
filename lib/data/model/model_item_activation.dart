/* 
Created by Neloy on 13 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelItemActivation {
  final String status;
  final String message;

  ModelItemActivation({required this.status, required this.message});

  factory ModelItemActivation.fromRawJson(String str) =>
      ModelItemActivation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelItemActivation.fromJson(Map<String, dynamic> json) =>
      ModelItemActivation(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}
