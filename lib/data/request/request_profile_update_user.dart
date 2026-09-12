/* 
Created by Neloy on 12 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class RequestProfileUpdateUser {
  final String firstName;
  final String lastName;
  final String address;
  // final String longitude;
  // final String latitude;

  const RequestProfileUpdateUser({
    required this.firstName,
    required this.lastName,
    required this.address,
    // required this.longitude,
    // required this.latitude,
  });

  Map<String, dynamic> toMap() => {
    'firstName': firstName,
    'lastName': lastName,
    'address': address,
    // 'longitude': longitude,
    // 'latitude': latitude,
    "longitude": "1234.55",
    "latitude": "1234.55",
  };
}
