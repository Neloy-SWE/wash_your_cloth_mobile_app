/* 
Created by Neloy on 29 June, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelLogin {
  final String status;
  final String message;
  final String token;
  final String refreshToken;
  final DateTime expirationToken;
  final DateTime expirationRefreshToken;

  ModelLogin({
    required this.status,
    required this.message,
    required this.token,
    required this.refreshToken,
    required this.expirationToken,
    required this.expirationRefreshToken,
  });

  factory ModelLogin.fromRawJson(String str) =>
      ModelLogin.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
    status: json["status"],
    message: json["message"],
    token: json["token"],
    refreshToken: json["refreshToken"],
    expirationToken: DateTime.parse(json["expirationToken"]),
    expirationRefreshToken: DateTime.parse(json["expirationRefreshToken"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "token": token,
    "refreshToken": refreshToken,
    "expirationToken": expirationToken.toIso8601String(),
    "expirationRefreshToken": expirationRefreshToken.toIso8601String(),
  };
}
