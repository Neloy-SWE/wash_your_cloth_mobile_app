/* 
Created by Neloy on 03 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelActivation {
  final String status;
  final String message;

  ModelActivation({required this.status, required this.message});

  factory ModelActivation.fromRawJson(String str) =>
      ModelActivation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelActivation.fromJson(Map<String, dynamic> json) =>
      ModelActivation(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}
