/* 
Created by Neloy on 11 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class RequestUpdateService {
  final String serviceName;
  final String description;

  RequestUpdateService({required this.serviceName, required this.description});

  Map<String, dynamic> toMap() => {
    'serviceName': serviceName,
    'description': description,
  };
}
