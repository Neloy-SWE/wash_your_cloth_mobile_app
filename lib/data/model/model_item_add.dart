/* 
Created by Neloy on 13 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelItemAdd {
  final String status;
  final String message;

  ModelItemAdd({required this.status, required this.message});

  factory ModelItemAdd.fromRawJson(String str) =>
      ModelItemAdd.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelItemAdd.fromJson(Map<String, dynamic> json) =>
      ModelItemAdd(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}