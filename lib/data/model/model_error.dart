/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelError {
  final List<String>? error;

  ModelError({this.error});

  factory ModelError.fromRawJson(String str) =>
      ModelError.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelError.fromJson(Map<String, dynamic> json) => ModelError(
    error: json["error"] == null
        ? []
        : List<String>.from(json["error"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? [] : List<dynamic>.from(error!.map((x) => x)),
  };
}
