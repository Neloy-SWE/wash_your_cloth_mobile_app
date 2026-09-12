/* 
Created by Neloy on 12 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelProfileUpdateUser {
  final String status;
  final String message;

  ModelProfileUpdateUser({required this.status, required this.message});

  factory ModelProfileUpdateUser.fromRawJson(String str) =>
      ModelProfileUpdateUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelProfileUpdateUser.fromJson(Map<String, dynamic> json) =>
      ModelProfileUpdateUser(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}
