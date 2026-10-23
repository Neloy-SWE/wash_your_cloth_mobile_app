/* 
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

class ModelNotificationList {
  final int currentPage;
  final int pageSize;
  final int totalItem;
  final List<NotificationItem> notifications;

  ModelNotificationList({
    required this.currentPage,
    required this.pageSize,
    required this.totalItem,
    required this.notifications,
  });

  factory ModelNotificationList.fromRawJson(String str) =>
      ModelNotificationList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelNotificationList.fromJson(Map<String, dynamic> json) =>
      ModelNotificationList(
        currentPage: (json["currentPage"] as num).toInt(),
        pageSize: (json["pageSize"] as num).toInt(),
        totalItem: (json["totalItem"] as num).toInt(),
        notifications: List<NotificationItem>.from(
          (json["notifications"] as List).map(
            (item) =>
                NotificationItem.fromJson(Map<String, dynamic>.from(item as Map)),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "pageSize": pageSize,
    "totalItem": totalItem,
    "notifications": List<dynamic>.from(notifications.map((x) => x.toJson())),
  };
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final bool isRead;
  final String navigation;
  final String metaData;
  final DateTime createdAt;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.isRead,
    required this.navigation,
    required this.metaData,
    required this.createdAt,
  });

  factory NotificationItem.fromRawJson(String str) =>
      NotificationItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
    id: json["id"] as String,
    title: json["title"] as String,
    message: json["message"] as String,
    isRead: json["isRead"] as bool,
    navigation: json["navigation"] as String,
    metaData: json["metaData"]?.toString() ?? "",
    createdAt: DateTime.parse(json["createdAt"] as String),
  );

  NotificationItem copyWith({bool? isRead}) => NotificationItem(
    id: id,
    title: title,
    message: message,
    isRead: isRead ?? this.isRead,
    navigation: navigation,
    metaData: metaData,
    createdAt: createdAt,
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
