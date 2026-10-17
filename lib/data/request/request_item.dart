/* 
Created by Neloy on 13 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class RequestItem {
  final String itemName;

  RequestItem({required this.itemName});

  Map<String, dynamic> toMap() => {'itemName': itemName};
}
