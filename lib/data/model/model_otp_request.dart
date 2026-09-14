/* 
Created by Neloy on 01 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelOTPRequest {
  final String status;
  final String message;
  final String otpRequestId;
  final String recordId;

  ModelOTPRequest({
    required this.status,
    required this.message,
    required this.otpRequestId,
    required this.recordId,
  });

  factory ModelOTPRequest.fromRawJson(String str) => ModelOTPRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelOTPRequest.fromJson(Map<String, dynamic> json) => ModelOTPRequest(
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
