/* 
Created by Neloy on 11 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelServiceUpdate {
  final String status;
  final String message;

  ModelServiceUpdate({required this.status, required this.message});

  factory ModelServiceUpdate.fromRawJson(String str) =>
      ModelServiceUpdate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelServiceUpdate.fromJson(Map<String, dynamic> json) =>
      ModelServiceUpdate(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}