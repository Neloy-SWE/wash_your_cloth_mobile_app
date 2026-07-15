/* 
Created by Neloy on 10 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class RegistrationData {
  final String? role;
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? phone;
  final String? password;
  final String? shopName;
  final String? openTime;
  final String? closeTime;
  final String? weekends;

  const RegistrationData({
    this.role,
    this.firstName,
    this.lastName,
    this.address,
    this.phone,
    this.password,
    this.shopName,
    this.openTime,
    this.closeTime,
    this.weekends,
  });

  Map<String, dynamic> toMapUser() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "address": address,
      "longitude": "1234.55",
      "latitude": "1234.55",
      "password": password,
      "role": role,
    };
  }

  Map<String, dynamic> toMapShop() {
    return {
      "ownerFirstName": firstName,
      "ownerLastName": lastName,
      "shopName": shopName,
      "phone": phone,
      "shopAddress": address,
      "longitude": "1234.55",
      "latitude": "1234.55",
      "password": password,
      "role": role,
      "openTime": openTime,
      "closeTime": closeTime,
      "weekends": weekends,
    };
  }
}

class UseCaseRegistration {
  String? message;
  String? otpRequestId;
  String? recordId;
  bool isNavigateOTP;

  UseCaseRegistration({
    this.recordId,
    this.otpRequestId,
    this.message,
    required this.isNavigateOTP,
  });
}
