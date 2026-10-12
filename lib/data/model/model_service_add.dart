/* 
Created by Neloy on 11 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelServiceAdd {
  final String status;
  final String message;

  ModelServiceAdd({required this.status, required this.message});

  factory ModelServiceAdd.fromRawJson(String str) =>
      ModelServiceAdd.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelServiceAdd.fromJson(Map<String, dynamic> json) =>
      ModelServiceAdd(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}