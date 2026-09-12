/* 
Created by Neloy on 30 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelProfileViewUser {
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final double longitude;
  final double latitude;
  final bool verified;

  ModelProfileViewUser({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.verified,
  });

  factory ModelProfileViewUser.fromRawJson(String str) =>
      ModelProfileViewUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelProfileViewUser.fromJson(Map<String, dynamic> json) =>
      ModelProfileViewUser(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        address: json["address"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "address": address,
    "longitude": longitude,
    "latitude": latitude,
    "verified": verified,
  };
}
