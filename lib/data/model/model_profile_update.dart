/* 
Created by Neloy on 12 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelProfileUpdate {
  final String status;
  final String message;

  ModelProfileUpdate({required this.status, required this.message});

  factory ModelProfileUpdate.fromRawJson(String str) =>
      ModelProfileUpdate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelProfileUpdate.fromJson(Map<String, dynamic> json) =>
      ModelProfileUpdate(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}
