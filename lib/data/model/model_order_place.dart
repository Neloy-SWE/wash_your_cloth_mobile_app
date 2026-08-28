/* 
Created by Neloy on 25 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelOrderPlace {
  final String status;
  final String message;

  ModelOrderPlace({required this.status, required this.message});

  factory ModelOrderPlace.fromRawJson(String str) =>
      ModelOrderPlace.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelOrderPlace.fromJson(Map<String, dynamic> json) =>
      ModelOrderPlace(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}
