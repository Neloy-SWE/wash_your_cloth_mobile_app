/* 
Created by Neloy on 13 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelItemUpdate {
  final String status;
  final String message;

  ModelItemUpdate({required this.status, required this.message});

  factory ModelItemUpdate.fromRawJson(String str) =>
      ModelItemUpdate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelItemUpdate.fromJson(Map<String, dynamic> json) =>
      ModelItemUpdate(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}