/* 
Created by Neloy on 21 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelOrderStatusUpdate {
  final String status;
  final String message;

  ModelOrderStatusUpdate({required this.status, required this.message});

  factory ModelOrderStatusUpdate.fromRawJson(String str) =>
      ModelOrderStatusUpdate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelOrderStatusUpdate.fromJson(Map<String, dynamic> json) =>
      ModelOrderStatusUpdate(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}
