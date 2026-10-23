/*
Created by Neloy on 23 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class ModelAuthAction {
  final String status;
  final String message;

  const ModelAuthAction({required this.status, required this.message});

  factory ModelAuthAction.fromJson(Map<String, dynamic> json) =>
      ModelAuthAction(
        status: json["status"] as String,
        message: json["message"] as String,
      );
}
