/* 
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelNotificationList {
  final int currentPage;
  final int pageSize;
  final int totalItem;
  final List<Notification> notifications;

  ModelNotificationList({
    required this.currentPage,
    required this.pageSize,
    required this.totalItem,
    required this.notifications,
  });

  factory ModelNotificationList.fromRawJson(String str) => ModelNotificationList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelNotificationList.fromJson(Map<String, dynamic> json) => ModelNotificationList(
    currentPage: json["currentPage"],
    pageSize: json["pageSize"],
    totalItem: json["totalItem"],
    notifications: List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "pageSize": pageSize,
    "totalItem": totalItem,
    "notifications": List<dynamic>.from(notifications.map((x) => x.toJson())),
  };
}

class Notification {
  final String id;
  final String title;
  final String message;
  final bool isRead;
  final String navigation;
  final String metaData;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.isRead,
    required this.navigation,
    required this.metaData,
    required this.createdAt,
  });

  factory Notification.fromRawJson(String str) => Notification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    title: json["title"],
    message: json["message"],
    isRead: json["isRead"],
    navigation: json["navigation"],
    metaData: json["metaData"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "message": message,
    "isRead": isRead,
    "navigation": navigation,
    "metaData": metaData,
    "createdAt": createdAt.toIso8601String(),
  };
}
