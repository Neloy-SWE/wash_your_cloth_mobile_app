/* 
Created by Neloy on 11 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelServiceActivation {
  final String status;
  final String message;

  ModelServiceActivation({required this.status, required this.message});

  factory ModelServiceActivation.fromRawJson(String str) =>
      ModelServiceActivation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelServiceActivation.fromJson(Map<String, dynamic> json) =>
      ModelServiceActivation(status: json["status"], message: json["message"]);

  Map<String, dynamic> toJson() => {"status": status, "message": message};
}
