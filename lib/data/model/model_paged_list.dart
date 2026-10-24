/*
Created by Neloy on 24 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class ModelPagedList<T> {
  final int currentPage;
  final int pageSize;
  final int totalItem;
  final List<T> items;

  const ModelPagedList({
    required this.currentPage,
    required this.pageSize,
    required this.totalItem,
    required this.items,
  });

  factory ModelPagedList.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson, {
    String itemsKey = 'items',
  }) => ModelPagedList<T>(
    currentPage: (json['currentPage'] as num).toInt(),
    pageSize: (json['pageSize'] as num).toInt(),
    totalItem: (json['totalItem'] as num).toInt(),
    items: (json[itemsKey] as List)
        .map((item) => fromJson(Map<String, dynamic>.from(item as Map)))
        .toList(),
  );
}
