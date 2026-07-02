/* 
Created by Neloy on 01 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelLoginUnverified {
  final String status;
  final String message;
  final String otpRequestId;
  final String recordId;

  ModelLoginUnverified({
    required this.status,
    required this.message,
    required this.otpRequestId,
    required this.recordId,
  });

  factory ModelLoginUnverified.fromRawJson(String str) => ModelLoginUnverified.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelLoginUnverified.fromJson(Map<String, dynamic> json) => ModelLoginUnverified(
    status: json["status"],
    message: json["message"],
    otpRequestId: json["otpRequestId"],
    recordId: json["recordId"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "otpRequestId": otpRequestId,
    "recordId": recordId,
  };
}
